# Command: analyze
# Description: Comprehensive code analysis
# Usage: claude analyze [target]

## Purpose

This command performs a comprehensive analysis of code, providing insights on:
- Code quality and maintainability
- Performance characteristics  
- Security vulnerabilities
- Testing coverage
- Architectural patterns

## Execution Protocol

When asked to "analyze" code or a system, I will:

### 1. Static Analysis
- **Complexity**: Calculate cyclomatic complexity
- **Dependencies**: Map dependency graph
- **Patterns**: Identify design patterns used
- **Anti-patterns**: Flag problematic patterns

### 2. Security Scan
- **OWASP Top 10**: Check for common vulnerabilities
- **Credentials**: Scan for hardcoded secrets
- **Injection**: Identify injection risks
- **Access Control**: Review authorization logic

### 3. Performance Profile
- **Big O**: Analyze algorithmic complexity
- **Database**: Check for N+1 queries
- **Memory**: Identify memory leaks
- **Concurrency**: Find race conditions

### 4. Quality Metrics
- **Test Coverage**: Measure and report
- **Documentation**: Assess completeness
- **Maintainability**: Calculate maintainability index
- **Technical Debt**: Estimate and prioritize

## Output Format

```markdown
# Code Analysis Report

## Executive Summary
- Overall Health: [Score/100]
- Critical Issues: [Count]
- Recommendations: [Top 3]

## Detailed Findings

### Security
[Detailed security findings]

### Performance  
[Performance analysis]

### Maintainability
[Code quality metrics]

### Testing
[Test coverage and quality]

## Recommendations
1. [Priority 1 - Critical]
2. [Priority 2 - High]
3. [Priority 3 - Medium]

## Next Steps
[Actionable items for improvement]
```

## Examples

### Basic Usage
```bash
# Analyze entire project
claude analyze

# Analyze specific file
claude analyze src/auth/service.go

# Analyze specific aspect
claude analyze:security
```

### Advanced Usage
```bash
# Deep analysis with benchmarks
claude analyze --deep --benchmark

# Focus on performance
claude analyze:performance src/

# Generate fix suggestions
claude analyze --suggest-fixes
```

## Configuration

Customize analysis in `.claude/commands/analyze.config.json`:
```json
{
  "thresholds": {
    "complexity": 10,
    "coverage": 80,
    "duplication": 5
  },
  "ignore": [
    "*_test.go",
    "vendor/",
    "node_modules/"
  ]
}
```