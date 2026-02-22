---
description: Review current code changes and report findings
---

Perform a focused code review for current changes.

Scope:
- Use `git status --short` and diff(s) to determine what changed.
- Review the changed files only, unless `$ARGUMENTS` asks for broader scope.

Review checklist:
1. Correctness and behavior regressions
2. Security issues
3. Reliability and edge cases
4. Maintainability and readability
5. Missing or insufficient tests

Output requirements:
1. List findings first, ordered by severity.
2. For each finding, include file path and line reference when possible.
3. Keep summaries concise and actionable.
4. If no findings exist, explicitly state "No findings".
5. Mention residual risks or testing gaps, if any.

Additional instruction:
$ARGUMENTS
