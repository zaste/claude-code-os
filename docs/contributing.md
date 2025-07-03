# Contributing to Claude Code OS

First off, thank you for considering contributing to Claude Code OS! It's people like you that make Claude Code OS such a great tool for the developer community.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)
- [Contributing Patterns](#contributing-patterns)
- [Pull Request Process](#pull-request-process)
- [Development Setup](#development-setup)
- [Style Guidelines](#style-guidelines)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

**Bug Report Template:**
```markdown
### Description
[Clear and concise description of the bug]

### To Reproduce
1. Install Claude Code OS with '...'
2. Create a file '...'
3. Run command '...'
4. See error

### Expected Behavior
[What you expected to happen]

### Actual Behavior
[What actually happened]

### Environment
- OS: [e.g., macOS 14.0]
- Claude Code Version: [e.g., 1.0.0]
- Environment: [Local/Codespaces/GitPod]
- Project Type: [React/Python/Go/etc.]

### Additional Context
[Any other context about the problem]
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a detailed description** of the suggested enhancement
- **Explain why this enhancement would be useful** to most users
- **List some examples** of how it would be used

### Contributing Patterns

One of the most valuable contributions is sharing effective patterns:

1. **Identify a Pattern**: Find a coding pattern that consistently improves quality/productivity
2. **Document It**: Create a clear description with examples
3. **Test It**: Ensure it works across different scenarios
4. **Submit It**: Create a PR with your pattern

**Pattern Template:**
```markdown
## Pattern: [Name]

### Context
[When should this pattern be used?]

### Problem
[What problem does it solve?]

### Solution
[How does the pattern work?]

### Example
```language
// Code example showing the pattern
```

### Benefits
- [Benefit 1]
- [Benefit 2]

### Trade-offs
- [Trade-off 1]
- [Trade-off 2]
```

## Pull Request Process

1. **Fork the Repository**: Create your own fork of the code
2. **Create a Branch**: Create a branch for your feature (`git checkout -b feature/amazing-feature`)
3. **Make Changes**: Make your changes and commit them
4. **Test**: Ensure your changes work as expected
5. **Document**: Update documentation if needed
6. **Submit PR**: Create a pull request with a clear description

### PR Template
```markdown
### Description
[What does this PR do?]

### Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Pattern contribution
- [ ] Documentation update

### Testing
- [ ] Tested locally
- [ ] Tested in Codespaces
- [ ] Added tests (if applicable)

### Checklist
- [ ] My code follows the project style
- [ ] I've updated documentation
- [ ] I've added tests (if applicable)
- [ ] All tests pass
```

## Development Setup

### Local Development

1. Clone the repository:
```bash
git clone https://github.com/zaste/claude-code-os.git
cd claude-code-os
```

2. Install dependencies (if any):
```bash
# Currently, no dependencies required
```

3. Test installation script:
```bash
./install.sh
```

### Testing Changes

1. **Test Core Functionality**:
```bash
# Test in a sample project
mkdir test-project
cd test-project
cp ../CLAUDE.md .
# Open with Claude Code and verify behavior
```

2. **Test Framework Templates**:
```bash
# Test each framework template
cp ../templates/react/CLAUDE.md .
# Verify React-specific features work
```

## Style Guidelines

### Markdown Style

- Use clear, concise language
- Include code examples where helpful
- Use proper heading hierarchy
- Include a table of contents for long documents

### Code Examples

- Provide working, tested examples
- Include comments explaining key concepts
- Follow language-specific conventions
- Keep examples focused and minimal

### Commit Messages

- Use clear, descriptive commit messages
- Start with a verb (Add, Fix, Update, etc.)
- Reference issues when applicable
- Keep the first line under 50 characters

**Examples:**
```
✨ Add Python async pattern examples
🔧 Fix installation script for GitPod
📝 Update React template for Next.js 14
🚀 Improve performance gate thresholds
```

## Pattern Effectiveness Criteria

When contributing patterns, consider:

1. **Clarity**: Is the pattern easy to understand?
2. **Applicability**: How widely can it be used?
3. **Impact**: Does it significantly improve code quality?
4. **Testability**: Can its effectiveness be measured?
5. **Trade-offs**: Are the downsides clearly documented?

## Community

- **Discussions**: Join our [GitHub Discussions](https://github.com/zaste/claude-code-os/discussions)
- **Issues**: Check [existing issues](https://github.com/zaste/claude-code-os/issues)
- **Updates**: Watch the repo for updates

## Recognition

Contributors are recognized in our:
- README.md contributors section
- Release notes
- Special thanks in major releases

## Questions?

If you have questions about contributing, feel free to:
- Open a discussion
- Create an issue with the "question" label
- Reach out to maintainers

Thank you for helping make Claude Code OS better for everyone! 🚀