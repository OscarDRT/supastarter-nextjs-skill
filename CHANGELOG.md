# Changelog

All notable changes to this skill will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-01-31

### Added
- **supastarter-nextjs-skill** – New Agent Skills–compliant skill (name matches folder per spec)
- 20+ reference docs: tech-stack, setup, configuration, troubleshooting, database-patterns, api-patterns, auth-patterns, organization-patterns, payments-patterns, ai-patterns, customization, storage-patterns, mailing-patterns, internationalization, seo, deployment, background-tasks, analytics, monitoring, e2e-testing
- Coding conventions, code patterns, and quick reference (migrated from previous skill)
- **scripts/generate_module.py** – Scaffold new oRPC API modules
- **assets/env.example** – Environment variables template
- **assets/recipes/feedback-widget.md** – Full recipe (DB → API → UI → i18n)
- README and marketplace.json updated for new skill; Cursor install paths documented

### Changed
- Skill folder renamed from `supastarter-nextjs/` to `supastarter-nextjs-skill/`
- marketplace.json `skills[0]` now points to `./supastarter-nextjs-skill`

### Removed
- **supastarter-nextjs/** – Replaced by supastarter-nextjs-skill

[1.1.0]: https://github.com/OscarDRT/supastarter-nextjs-skill/releases/tag/v1.1.0

## [1.0.0] - 2026-01-30

### Added
- Initial release of supastarter Next.js skill
- Complete documentation of supastarter architecture
- Coding conventions from official supastarter guide
- Code patterns for common tasks:
  - Database models and queries (Prisma/Drizzle)
  - API routes (Hono.js)
  - Frontend components (Next.js App Router)
  - Authentication flows
  - Organization management
- Quick reference guide with commands and troubleshooting
- Support for progressive disclosure to minimize context usage

### Features
- Automatic activation when supastarter is mentioned
- Convention-compliant code generation
- Multi-tenancy patterns
- Billing integration patterns
- Admin panel patterns

[1.0.0]: https://github.com/OscarDRT/supastarter-nextjs-skill/releases/tag/v1.0.0
