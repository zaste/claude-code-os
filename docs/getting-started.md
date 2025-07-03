# Getting Started with Claude Code OS

## What is Claude Code OS?

Claude Code OS is a behavioral conditioning system that transforms Claude Code into a consistent, intelligent senior developer. Think of it as an "operating system" layer that enhances Claude's capabilities.

## Installation

### Quick Install (Recommended)

```bash
curl -sSL https://claude.dev/os | bash
```

This script will:
1. Detect your environment (local, Codespaces, GitPod)
2. Identify your project type (React, Python, Go, etc.)
3. Download the appropriate CLAUDE.md
4. Optionally set up advanced features

### Manual Installation

1. Download CLAUDE.md to your project root:
```bash
curl -s https://raw.githubusercontent.com/zaste/claude-code-os/main/CLAUDE.md > CLAUDE.md
```

2. That's it! Claude will automatically activate when you use it in this directory.

## How It Works

1. **Automatic Activation**: When Claude Code sees CLAUDE.md in your project, it automatically loads the behavioral protocols.

2. **Enhanced Behavior**: Claude now:
   - Thinks systematically before responding
   - Applies quality gates to all code
   - Maintains project context
   - Makes consistent decisions
   - Follows best practices

3. **Progressive Enhancement**: Start simple with just CLAUDE.md, then add advanced features as needed.

## Your First Session

After installation, try these commands to see the difference:

```bash
# Claude now thinks like a senior developer
claude "Create a user authentication system"

# Claude maintains context and makes informed decisions
claude "What's the best way to handle errors in this project?"

# Claude applies quality gates automatically
claude "Refactor this function for better performance"
```

## Understanding the Protocols

### Thinking Framework
Claude now follows a structured thinking process:
1. Analyze the request type
2. Consider multiple approaches
3. Evaluate trade-offs
4. Apply quality gates
5. Provide the best solution

### Quality Gates
Every piece of code goes through:
- Security checks
- Performance analysis  
- Maintainability review
- Testing requirements

### Memory System
Claude can maintain project context:
- Decision history
- Discovered patterns
- Project conventions
- Team preferences

## Framework-Specific Features

If you're using a specific framework, consider using the optimized template:

- **React**: Includes React-specific patterns, hooks best practices, Next.js optimizations
- **Python**: Django/FastAPI patterns, async best practices, testing strategies
- **Go**: Concurrency patterns, error handling, performance optimizations

## Progressive Enhancement

Start with basic features and add more as needed:

### Level 1: Basic (Default)
- Just CLAUDE.md
- Senior developer behavior
- Quality gates
- Best practices

### Level 2: Advanced
Create `.claude/` directory for:
- Custom commands
- Project memory
- Team protocols

### Level 3: Team
- Shared configurations
- Team knowledge base
- Consistent patterns across developers

## Troubleshooting

### Claude doesn't seem enhanced
- Ensure CLAUDE.md is in the project root
- Check if Claude Code has access to read files
- Try restarting Claude Code

### Installation fails
- Check internet connection
- Ensure curl is installed
- Try manual installation

### Custom commands not working
- Verify `.claude/commands/` directory exists
- Check command file format
- Ensure proper permissions

## Next Steps

1. **Explore Advanced Features**: See [advanced-usage.md](advanced-usage.md)
2. **Customize for Your Team**: Learn about team features
3. **Contribute**: Share patterns that work well for you

## Getting Help

- **GitHub Issues**: [Report bugs or request features](https://github.com/zaste/claude-code-os/issues)
- **Discussions**: [Join the community](https://github.com/zaste/claude-code-os/discussions)
- **Updates**: Watch the repo for new features

Welcome to a new level of AI-assisted development! 🚀