# Advanced Usage Guide

## Table of Contents
- [Custom Commands](#custom-commands)
- [Project Memory](#project-memory)
- [Team Synchronization](#team-synchronization)
- [Quality Gates](#quality-gates)
- [Environment-Specific Configuration](#environment-specific-configuration)
- [Analytics and Metrics](#analytics-and-metrics)

## Custom Commands

Custom commands let you create reusable workflows for common tasks.

### Creating a Custom Command

1. Create a command file in `.claude/commands/`:
```bash
mkdir -p .claude/commands
touch .claude/commands/review.md
```

2. Define the command:
```markdown
# Command: review
# Description: Comprehensive code review

## Execution Protocol

When asked to "review" code, I will:

1. **Security Analysis**
   - Check for vulnerabilities
   - Validate input handling
   - Review authentication/authorization

2. **Performance Review**
   - Analyze algorithmic complexity
   - Check for N+1 queries
   - Review caching strategy

3. **Code Quality**
   - Verify SOLID principles
   - Check naming conventions
   - Review error handling

4. **Testing Assessment**
   - Verify test coverage
   - Check edge cases
   - Review test quality

## Output Format

Provide a structured report with:
- Executive summary
- Critical issues (if any)
- Recommendations
- Code examples for improvements
```

### Using Custom Commands

```bash
# Invoke the custom command
claude "review the user service"

# Claude will follow the review protocol defined above
```

## Project Memory

Enable Claude to maintain context across sessions.

### Setting Up Memory

```bash
mkdir -p .claude/memory
```

### Memory Files

#### decisions.log
Tracks important decisions:
```
[2025-01-03 10:23:45] DECISION: Use PostgreSQL for primary database
CONTEXT: Need ACID compliance and complex queries
RATIONALE: PostgreSQL provides better support for our use case than MongoDB
ALTERNATIVES: MongoDB (rejected due to transaction requirements)
OUTCOME: Improved query performance and data consistency
```

#### patterns.md
Documents discovered patterns:
```markdown
## Pattern: Repository Error Handling
- **Context**: Database operations
- **Solution**: Wrap all DB errors with context
- **Example**: `fmt.Errorf("get user %s: %w", userID, err)`
```

#### context.json
Project understanding:
```json
{
  "project_type": "microservices",
  "tech_stack": ["go", "postgresql", "redis", "kubernetes"],
  "conventions": {
    "naming": "snake_case for files, PascalCase for types",
    "structure": "domain-driven design"
  },
  "team_preferences": {
    "testing": "table-driven tests preferred",
    "logging": "structured logging with slog"
  }
}
```

## Team Synchronization

Share patterns and knowledge across your team.

### Setting Up Team Sync

1. Create team configuration:
```bash
mkdir -p .claude/team
touch .claude/team/config.json
```

2. Configure team settings:
```json
{
  "team_name": "backend-team",
  "sync_enabled": true,
  "shared_patterns": true,
  "shared_decisions": true,
  "sync_url": "https://your-team-sync-server.com"
}
```

### Shared Protocols

Create team-wide protocols in `.claude/team/protocols.md`:
```markdown
# Team Protocols

## Code Review Process
1. All PRs require 2 approvals
2. Security review for auth changes
3. Performance review for database changes

## API Design Standards
- RESTful conventions
- Consistent error responses
- Pagination for list endpoints
- Rate limiting on all public endpoints
```

## Quality Gates

Customize quality gates for your project.

### Custom Gate Configuration

`.claude/gates/security.yml`:
```yaml
security_gate:
  checks:
    - no_hardcoded_secrets
    - sql_injection_prevention
    - xss_protection
    - csrf_tokens
    - secure_headers
  
  severity_levels:
    critical: ["sql_injection", "authentication_bypass"]
    high: ["xss", "insecure_direct_references"]
    medium: ["missing_csrf", "weak_encryption"]
    
  auto_block:
    - hardcoded_credentials
    - eval_usage
    - unsafe_deserialization
```

### Performance Gates

`.claude/gates/performance.yml`:
```yaml
performance_gate:
  thresholds:
    response_time: 100ms
    query_count: 10
    memory_usage: 512MB
    
  optimizations:
    - query_optimization
    - caching_strategy
    - connection_pooling
    - lazy_loading
```

## Environment-Specific Configuration

### Codespaces Configuration

`.claude/environments/codespaces.json`:
```json
{
  "optimizations": {
    "context_window": "aggressive",
    "response_streaming": true,
    "code_completion": "fast"
  },
  "features": {
    "auto_commit_messages": true,
    "pr_descriptions": true,
    "issue_templates": true
  }
}
```

### Local Development

`.claude/environments/local.json`:
```json
{
  "optimizations": {
    "context_window": "balanced",
    "detailed_explanations": true,
    "debugging_helpers": true
  }
}
```

## Analytics and Metrics

### Tracking Effectiveness

Enable anonymous metrics to help improve the system:

`.claude/settings.json`:
```json
{
  "analytics": {
    "enabled": true,
    "anonymous": true,
    "track_patterns": true,
    "track_effectiveness": true
  },
  "privacy": {
    "no_code_sharing": true,
    "no_pii": true,
    "local_only": false
  }
}
```

### Local Metrics

View your local effectiveness metrics:

```bash
# Generate metrics report
claude metrics:report

# Example output:
# Code Quality Score: 94.2%
# Bug Prevention Rate: 87.5%
# Development Speed: +34%
# Pattern Effectiveness: 91.8%
```

## Advanced Patterns

### Multi-Repository Setup

For monorepos or multi-repo projects:

```bash
# Root level
CLAUDE.md  # Base configuration

# Service level
services/api/.claude/overrides.md  # Service-specific overrides
services/web/.claude/overrides.md  # Web-specific patterns
```

### CI/CD Integration

Integrate with your CI/CD pipeline:

`.github/workflows/claude-check.yml`:
```yaml
name: Claude Quality Gates

on: [pull_request]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run Claude Quality Gates
        run: |
          claude check:security
          claude check:performance
          claude check:testing
```

## Best Practices

1. **Start Simple**: Begin with just CLAUDE.md and add features as needed
2. **Document Decisions**: Use the memory system to track important choices
3. **Share Knowledge**: Enable team sync for consistency
4. **Measure Success**: Track metrics to validate improvements
5. **Iterate**: Continuously refine your protocols based on what works

## Troubleshooting Advanced Features

### Memory not persisting
- Check file permissions in `.claude/memory/`
- Ensure Claude has write access
- Verify JSON syntax in context.json

### Custom commands not recognized
- Command files must be in `.claude/commands/`
- Use .md extension
- Start with `# Command: [name]`

### Team sync issues
- Verify network connectivity
- Check sync_url configuration
- Ensure proper authentication

For more help, see our [GitHub Issues](https://github.com/zaste/claude-code-os/issues).