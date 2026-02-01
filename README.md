# supastarter Next.js Skill

> Agent Skills–compliant skill for [supastarter](https://supastarter.dev) **Next.js only** (no Vue/Nuxt). Expert guidance for the full stack: tech stack, setup, database (Prisma), API (Hono/oRPC), auth (Better Auth), organizations, payments (Stripe), AI, customization, storage, mailing, i18n, SEO, deployment, background tasks, analytics, monitoring, E2E.

[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Compatible-blue)](https://agentskills.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## What is this?

This skill provides comprehensive guidance for building production-ready SaaS applications with supastarter for Next.js, including:

- ✅ **SKILL.md** – When to use, workflow (schema → queries → API → UI → i18n), pointers to references and assets
- ✅ **20+ reference docs** – Tech stack, setup, configuration, troubleshooting, database, API, auth, organizations, payments, AI, customization, storage, mailing, i18n, SEO, deployment, background tasks, analytics, monitoring, E2E
- ✅ **Coding conventions** – Official supastarter coding style and architecture (read first before writing code)
- ✅ **Code patterns** – Prisma, oRPC, Server/Client components, forms, shadcn, auth, organizations
- ✅ **Quick reference** – Commands, file locations, env template, troubleshooting, deployment checklist
- ✅ **Scripts** – `generate_module.py` to scaffold new API modules (oRPC)
- ✅ **Assets** – `env.example`, full **feedback-widget** recipe (DB → API → UI → i18n)

## Installation

### Using npx skills (when supported)

```bash
# Install from GitHub
npx skills add OscarDRT/supastarter-nextjs-skill

# Or with full URL
npx skills add https://github.com/OscarDRT/supastarter-nextjs-skill
```

The skill directory is **supastarter-nextjs-skill** (Agent Skills spec: name matches folder).

### Manual Installation (Cursor)

1. Clone or download this repository
2. Copy the **supastarter-nextjs-skill** folder to one of these locations:
   - `~/.cursor/skills/supastarter-nextjs-skill/` (global)
   - `.cursor/skills/supastarter-nextjs-skill/` (project-specific)

Do not use `~/.cursor/skills-cursor/` (reserved for Cursor).

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

### Skill layout (supastarter-nextjs-skill/)

- **SKILL.md** – Frontmatter (name, description) + when to use, workflow, references table, scripts, conventions
- **references/** – 23 markdown files: coding-conventions, code-patterns, quick-reference, tech-stack, setup, configuration, troubleshooting, database-patterns, api-patterns, auth-patterns, organization-patterns, payments-patterns, ai-patterns, customization, storage-patterns, mailing-patterns, internationalization, seo, deployment, background-tasks, analytics, monitoring, e2e-testing
- **scripts/** – `generate_module.py` (scaffold oRPC module), `README.md` (usage)
- **assets/** – `env.example`, `recipes/feedback-widget.md` (full DB → API → UI → i18n recipe)

### Coding conventions (references/coding-conventions.md)
Read first before writing code: architecture, TypeScript, React/Next.js, styling, forms, API, auth, i18n, tooling.

### Code patterns (references/code-patterns.md)
Ready-to-use examples: Prisma models/queries, oRPC + TanStack Query, Server/Client components, react-hook-form + zod, shadcn, auth, organizations.

### Quick reference (references/quick-reference.md)
Commands, file locations (including oRPC paths), env template, troubleshooting, deployment checklist.

## Requirements

Works with any Agent Skills-compatible tool:

- ✅ Claude Code
- ✅ Claude Desktop (with skills enabled)
- ✅ OpenAI Codex CLI
- ✅ Cursor (via skills)
- ✅ Any tool supporting the Agent Skills format

## Example Workflow

```bash
# 1. Install the skill (e.g. copy supastarter-nextjs-skill to ~/.cursor/skills/)
cp -r supastarter-nextjs-skill ~/.cursor/skills/

# 2. Open Cursor (or another Agent Skills–compatible tool)

# 3. Ask for help with supastarter Next.js
"Build a feedback widget following the supastarter recipe"

# The skill activates and provides:
# - Workflow: schema → queries → API → UI → i18n
# - References (conventions, patterns, quick reference)
# - Full feedback-widget recipe in assets/recipes/
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
Based on supastarter Next.js architecture:
- Next.js 14+ App Router
- Prisma (schema, migrations, queries in `packages/database`)
- Better Auth
- Hono + oRPC (`packages/api/modules/`, procedures, router)
- Biome for lint/format

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
