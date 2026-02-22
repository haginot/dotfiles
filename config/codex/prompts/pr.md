---
description: Create a GitHub Pull Request using gh pr create
---

Create a GitHub Pull Request with `gh pr create`.

Requirements:
1. Confirm current branch (`git branch --show-current`) and stop if branch is `main` or `master`.
2. Confirm there are commits to open as PR against the default base branch.
3. Build a clear PR title and body from commit history and diffs.
4. Use `gh pr create` to open the PR.
5. If `$ARGUMENTS` includes options (for example base branch, title style, reviewers), apply them when creating the PR.
6. Report:
   - PR URL
   - base branch
   - head branch
   - PR title

Additional instruction:
$ARGUMENTS
