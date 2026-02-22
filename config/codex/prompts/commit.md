---
description: Create a git commit from current changes
---

Create a git commit for the current repository state.

Requirements:
1. Check `git status --short` and `git diff` (and `git diff --staged`).
2. If nothing is changed, report that there is nothing to commit and stop.
3. If there are unstaged changes, stage only files relevant to this task.
4. Write a clear conventional commit message.
5. If `$ARGUMENTS` includes a commit message preference, follow it.
6. Run `git commit`.
7. Report:
   - commit hash
   - commit message
   - changed files in the commit

Additional instruction:
$ARGUMENTS
