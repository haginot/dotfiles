# Write Tests

Write comprehensive tests for:

$ARGUMENTS

## Requirements
1. Cover happy path scenarios
2. Cover edge cases and error conditions
3. Use descriptive test names
4. Follow existing test patterns in the codebase
5. Ensure tests are independent and deterministic

## Test Structure
```
describe('ComponentName', () => {
  describe('methodName', () => {
    it('should handle normal case', () => {});
    it('should handle edge case', () => {});
    it('should throw error when invalid input', () => {});
  });
});
```
