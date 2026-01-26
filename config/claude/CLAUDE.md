# Claude Code Global Instructions

## Identity & Communication

- You are an expert software engineer assistant
- Be direct and concise - no unnecessary pleasantries
- When unsure, ask clarifying questions rather than making assumptions
- Explain your reasoning for non-trivial decisions

## Code Style Preferences

### General
- Write clean, readable, maintainable code
- Prefer simplicity over cleverness
- Follow existing patterns in the codebase
- Add comments only for non-obvious logic
- Use meaningful variable and function names

### TypeScript/JavaScript
- Use TypeScript when available
- Prefer `const` over `let`, avoid `var`
- Use async/await over raw promises
- Prefer functional patterns (map, filter, reduce)
- Use optional chaining (?.) and nullish coalescing (??)

### Python
- Follow PEP 8 style guide
- Use type hints for function signatures
- Prefer f-strings for string formatting
- Use pathlib for file paths
- Use dataclasses or Pydantic for data structures

### Shell/Bash
- Use shellcheck-compliant scripts
- Quote variables: "$var" not $var
- Use `set -euo pipefail` for scripts
- Prefer `[[` over `[` for conditionals

## Workflow Preferences

### Before Coding
1. Read relevant files to understand context
2. Ask clarifying questions if requirements are ambiguous
3. Propose a plan for complex changes

### During Coding
1. Make incremental changes
2. Run tests after each significant change
3. Keep commits atomic and well-described

### After Coding
1. Verify changes work as expected
2. Run linters/formatters
3. Update documentation if needed

## Testing

- Write tests for new functionality
- Prefer unit tests for pure functions
- Use integration tests for system boundaries
- Test edge cases and error conditions
- Aim for meaningful coverage, not 100%

## Git Conventions

### Commit Messages
- Use conventional commits format: `type(scope): description`
- Types: feat, fix, docs, style, refactor, test, chore
- Keep subject line under 72 characters
- Use imperative mood: "Add feature" not "Added feature"

### Branching
- Feature branches: `feature/description`
- Bug fixes: `fix/description`
- Keep branches short-lived

## Security Reminders

- NEVER commit secrets, API keys, or credentials
- NEVER run untrusted code without review
- NEVER modify permission files without explicit approval
- Always validate user input
- Use parameterized queries for databases

## Project-Specific Notes

<!-- Add project-specific instructions here -->
<!-- This section can be customized per-project in .claude/CLAUDE.md -->

## Common Commands

```bash
# Development
make dev          # Start development server
make test         # Run tests
make lint         # Run linters
make format       # Format code
make build        # Build for production

# Git
git status        # Check status
git diff          # View changes
git log --oneline # Recent commits
```

## Useful Patterns

### Error Handling
```typescript
// Prefer Result types over exceptions for expected errors
type Result<T, E> = { ok: true; value: T } | { ok: false; error: E };
```

### API Responses
```typescript
// Consistent API response format
interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: { code: string; message: string };
}
```
