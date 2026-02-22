# Dotfiles Agent Instructions

## Project Context
- This repository automates macOS setup with dotfiles.
- Any macOS setting change or app/package install/uninstall must be reflected in this repository in the same task.

## Task Contract
- Work in small, issue-sized changes (roughly one focused outcome per task).
- Prefer explicit file paths, commands, and expected outputs.
- State assumptions when requirements are ambiguous, then proceed pragmatically.
- For non-trivial changes, present a short plan before editing.

## Implementation Rules
- Follow existing repository structure and naming conventions.
- Keep changes minimal and directly related to the requested outcome.
- Do not introduce machine-local one-off changes without documenting and codifying them.
- Validate changes with relevant commands (examples: `make test`, `make doctor`, `make macos` as applicable).

## Response Format
- Summarize what changed and why.
- List touched files with paths.
- Report validation commands run and outcomes.
- Mention residual risks or follow-ups only if they are real blockers.

## Prompt Template (Recommended)
Use this structure when requesting work from Codex:

```text
Goal:
- What outcome you want.

Scope:
- In-scope files/areas.
- Out-of-scope items.

Constraints:
- Style, safety, compatibility, or performance constraints.

Acceptance Criteria:
- Concrete checks that define "done".

Validation:
- Exact commands Codex should run to verify changes.
```
