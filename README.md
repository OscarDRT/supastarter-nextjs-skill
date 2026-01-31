# supastarter Next.js Skill

> Expert guidance for working with the [supastarter](https://supastarter.dev) Next.js SaaS starter kit.

[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Compatible-blue)](https://agentskills.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## What is this?

This Agent Skill provides comprehensive guidance for building production-ready SaaS applications with supastarter, including:

- ✅ **Complete tech stack knowledge** - Next.js, Prisma, Hono.js, better-auth, and more
- ✅ **Project structure** - Monorepo patterns and organization
- ✅ **Coding conventions** - Official supastarter coding style and architectural patterns
- ✅ **Common code patterns** - Authentication, billing, multi-tenancy, and more
- ✅ **Quick reference** - Commands, troubleshooting, and deployment checklist

## Installation

### Using npx skills (Recommended)

```bash
# Install from GitHub
npx skills add OscarDRT/supastarter-nextjs-skill

# Or with full URL
npx skills add https://github.com/OscarDRT/supastarter-nextjs-skill
```

### Using Claude Code

```bash
# In Claude Code CLI
/plugin install supastarter-nextjs@OscarDRT-supastarter-nextjs-skill
```

### Manual Installation

1. Download this repository
2. Copy the skill folder to one of these locations:
   - `~/.claude/skills/supastarter-nextjs/` (global)
   - `.claude/skills/supastarter-nextjs/` (project-specific)

## Usage

Once installed, the skill automatically activates when you:

- Mention "supastarter" in your queries
- Ask about building SaaS features
- Request help with Next.js authentication, billing, or organizations
- Need to generate code following supastarter conventions

### Example Queries

**Building Features:**
```
"Help me build a task management feature in supastarter"
"Show me how to add a new database model in supastarter"
"Create a server component for displaying user analytics"
```

**Following Conventions:**
```
"Generate a new API route following supastarter conventions"
"Create a form component with proper validation"
"Show me the right way to handle authentication in supastarter"
```

**Troubleshooting:**
```
"I'm getting database connection errors in supastarter"
"How do I fix TypeScript errors after updating Prisma?"
"My build is failing, help me debug it"
```

## What's Included

### Main Documentation
- Complete supastarter overview
- Tech stack details
- Project structure explanation
- All major features covered
- Development workflows
- Deployment guidance
- Best practices

### Coding Conventions
Your project's source of truth for:
- Architecture patterns
- TypeScript conventions
- React & Next.js patterns
- Styling with shadcn/ui
- Form handling
- API development
- Database patterns
- Tooling (pnpm, Biome, Turbo)

### Code Patterns
Ready-to-use examples:
- Database queries (Prisma/Drizzle)
- API routes (Hono.js)
- Frontend components (Next.js)
- Authentication flows
- Organization management
- All copy-paste ready!

### Quick Reference
- Common commands cheat sheet
- File locations
- Environment variables template
- Troubleshooting guide
- Deployment checklist

## Requirements

Works with any Agent Skills-compatible tool:

- ✅ Claude Code
- ✅ Claude Desktop (with skills enabled)
- ✅ OpenAI Codex CLI
- ✅ Cursor (via skills)
- ✅ Any tool supporting the Agent Skills format

## Example Workflow

```bash
# 1. Install the skill
npx skills add OscarDRT/supastarter-nextjs-skill

# 2. Start your AI assistant
# Claude Code, Cursor, etc.

# 3. Ask for help with supastarter
"Help me implement role-based permissions in my supastarter app"

# The skill automatically activates and provides:
# - Architectural guidance
# - Code following conventions
# - Best practices
# - Working examples
```

## Features

### 🎯 Intelligent Activation
The skill knows when to activate based on context - no need to manually invoke it.

### 📚 Progressive Disclosure
Information is loaded on-demand to keep context efficient:
1. Metadata always available
2. Main docs when skill activates
3. Detailed references as needed

### ✨ Convention Compliance
All generated code follows supastarter's official conventions:
- Named exports for components
- Interfaces over types
- Server Components by default
- react-hook-form + zod for forms
- And 20+ more conventions

### 🔄 Up-to-date Patterns
Based on modern supastarter architecture (2025+):
- Next.js 14+ App Router
- Prisma + Drizzle
- better-auth
- oRPC for API
- Biome for tooling

## Contributing

Issues and PRs welcome! If you find bugs or have suggestions:

1. Check existing issues first
2. Open a new issue with details
3. Or submit a PR with fixes/improvements

## Related Resources

- [supastarter Official Site](https://supastarter.dev)
- [supastarter Documentation](https://supastarter.dev/docs/nextjs)
- [Agent Skills Specification](https://agentskills.io)
- [Agent Skills Examples](https://github.com/anthropics/skills)
- [Skills Marketplace](https://skillsmp.com)

## License

MIT - See [LICENSE](LICENSE) file for details.

## Disclaimer

This is a community-created skill to help developers work with supastarter. supastarter itself is a commercial product - please refer to their [official website](https://supastarter.dev) for licensing and purchase information.

## Star History

If you find this skill useful, please consider giving it a ⭐ on GitHub!

---

**Made with ❤️ for the supastarter community**
