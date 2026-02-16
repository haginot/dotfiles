#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_PLIST="$HOME/Library/Preferences/com.apple.HIToolbox.plist"
GOOGLE_CONFIG="$HOME/Library/Application Support/Google/JapaneseInput/config1.db"
PROTO_FILE="${SCRIPT_DIR}/../assets/mozc_config.proto"

input_changed=0
google_changed=0

if [ -f "$INPUT_PLIST" ]; then
  if INPUT_PLIST="$INPUT_PLIST" python3 <<'PY'
import os
import plistlib
from pathlib import Path

plist_path = Path(os.environ["INPUT_PLIST"])
with plist_path.open("rb") as plist_file:
    data = plistlib.load(plist_file)

def jp_entry(mode_id: str) -> dict:
    return {
        "Bundle ID": "com.google.inputmethod.Japanese",
        "Input Mode": mode_id,
        "InputSourceKind": "Input Mode",
    }

main_sources = [
    jp_entry("com.apple.inputmethod.Japanese"),
    jp_entry("com.apple.inputmethod.Roman"),
]

non_keyboard = [
    entry
    for entry in data.get("AppleEnabledInputSources", [])
    if entry.get("InputSourceKind") != "Input Mode"
]

target_enabled = main_sources + non_keyboard
target_selected = [main_sources[0]]
target_history = main_sources.copy()
target_layout = "com.google.inputmethod.Japanese.base"

changed = False
if data.get("AppleEnabledInputSources") != target_enabled:
    data["AppleEnabledInputSources"] = target_enabled
    changed = True
if data.get("AppleSelectedInputSources") != target_selected:
    data["AppleSelectedInputSources"] = target_selected
    changed = True
if data.get("AppleInputSourceHistory") != target_history:
    data["AppleInputSourceHistory"] = target_history
    changed = True
if data.get("AppleCurrentKeyboardLayoutInputSourceID") != target_layout:
    data["AppleCurrentKeyboardLayoutInputSourceID"] = target_layout
    changed = True

if changed:
    with plist_path.open("wb") as plist_file:
        plistlib.dump(data, plist_file)
    raise SystemExit(0)
raise SystemExit(2)
PY
  then
    input_changed=1
  else
    rc=$?
    if [ "$rc" -ne 2 ]; then
      exit "$rc"
    fi
  fi
fi

if [ -f "$GOOGLE_CONFIG" ] && command -v protoc >/dev/null 2>&1; then
  TMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TMP_DIR"' EXIT

  cp "$PROTO_FILE" "${TMP_DIR}/config.proto"
  protoc -I "${TMP_DIR}" --decode mozc.config.Config config.proto < "$GOOGLE_CONFIG" > "${TMP_DIR}/config.textproto"

  if TEXT_PROTO="${TMP_DIR}/config.textproto" python3 <<'PY'
import os
import re
from pathlib import Path

text_path = Path(os.environ["TEXT_PROTO"])
text = text_path.read_text()
original = text

def ensure_field(body: str, field: str, value: str) -> str:
    pattern = re.compile(rf"^{re.escape(field)}:\s+.+$", re.MULTILINE)
    replacement = f"{field}: {value}"
    if pattern.search(body):
        return pattern.sub(replacement, body)
    return body.strip() + "\n" + replacement + "\n"

text = ensure_field(text, "auto_switch_composition_mode", "false")
text = ensure_field(text, "preedit_method", "ROMAN")
text = ensure_field(text, "use_keyboard_to_change_preedit_method", "true")
text = ensure_field(text, "use_japanese_layout", "false")

if text != original:
    text_path.write_text(text)
    raise SystemExit(0)
raise SystemExit(2)
PY
  then
    protoc -I "${TMP_DIR}" --encode mozc.config.Config config.proto < "${TMP_DIR}/config.textproto" > "${TMP_DIR}/config.bin"
    cp "$GOOGLE_CONFIG" "${GOOGLE_CONFIG}.$(date +%Y%m%d%H%M%S).bak"
    mv "${TMP_DIR}/config.bin" "$GOOGLE_CONFIG"
    google_changed=1
  else
    rc=$?
    if [ "$rc" -ne 2 ]; then
      exit "$rc"
    fi
  fi
fi

if [ "$input_changed" -eq 1 ]; then
  killall cfprefsd >/dev/null 2>&1 || true
fi

if [ "$google_changed" -eq 1 ]; then
  killall GoogleJapaneseInput >/dev/null 2>&1 || true
fi
