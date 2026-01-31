## Claude Coding Guide

### Purpose
- Use this doc whenever you generate or update code in this repository.
- Mirror the existing project conventions; do not invent new patterns without a strong reason.

### Architecture Overview
- Frontend lives in the Next.js App Router at `apps/web/app`; prefer React Server Components by default.
- Shared UI, marketing, auth, and SaaS modules live under `apps/web/modules`.
- Backend logic resides in `packages/*`:
  - `api` for orpc procedures and HTTP handlers.
  - `auth` for Better Auth configuration plus invitation/passkey helpers.
  - `database` for Prisma + Drizzle clients, schema, and queries.
  - `ai`, `logs`, `mail`, `payments`, `storage`, `utils`, `i18n` for their respective domains.
- Use the package exports (e.g., `@repo/api`, `@repo/auth`) instead of deep relative imports.

### Core Coding Principles
- Write TypeScript everywhere; use interfaces over type aliases when describing object shapes.
- Export React components as named functions; avoid default exports and classes.
- Prefer pure functions declared with the `function` keyword.
- Avoid enums; use maps/records or union literals.
- Keep components declarative and presentational; extract helpers for imperative logic.
- Use descriptive camelCase identifiers (`isLoading`, `canSubmit`); directories use kebab-case.

### React & Next.js Patterns
- Favor React Server Components; only add `"use client"` when interactivity or browser APIs demand it.
- Wrap client components in `Suspense` with a tailored fallback.
- Use Next.js data-fetching primitives (Route Handlers, Server Actions, `fetch` with caching tags) per [supastarter docs](https://supastarter.dev/docs/nextjs).
- colocate route-specific helpers under the route directory; share cross-route logic via `apps/web/modules`.
- Handle errors with `notFound()`, `redirect()`, or custom error boundaries instead of throwing raw errors.

### Styling & UI
- Compose UI with Shadcn UI, Radix primitives, and Tailwind CSS utilities.
- Import and use the local `cn` helper for conditional class names.
- Follow mobile-first responsive utility ordering; respect the design tokens from `tooling/tailwind/theme.css`.
- Keep assets optimized (`next/image` with explicit `width`/`height`, WebP when possible, lazy-load non-critical visuals).

### State & Forms
- When client state is required, reach for colocation inside components or dedicated hooks within `apps/web/modules/shared`.
- Reuse existing form abstractions (e.g., zod validators, form components) before adding new ones.
- Use react-hook-form for forms and zod as the schema & validation library.

### Data & APIs
- If possible, add all the API and data fetching logic to the `@repo/api` package, to sustain a single source of truth for the API and a reusable API.
- Group logic in the API routes in the `packages/api/modules` directory into meaningful modules.
- Use the generated database clients from `@repo/database`; never instantiate Prisma or Drizzle directly in app code.
- Honor caching and revalidation patterns already in the repo (check adjacent files before introducing new cache strategies).

### Authentication & Authorization
- Use helpers from `@repo/auth` for session handling, invitations, passkeys, and organization management.
- Respect organization scoping: access control helpers live in `apps/web/modules/saas/*/lib`.
- When updating auth flows, ensure accompanying email templates (`packages/mail/emails`) and audit hooks stay consistent.

### Internationalization
- Strings should be sourced via the i18n utilities in `packages/i18n` or the content collections in `apps/web/content`.
- Honor locale detection (`config.i18n`) and cookie naming conventions when touching auth or routing.

### Tooling & Quality
- Package manager: pnpm. Run workspace-wide commands via Turbo (`pnpm dev`, `pnpm build`, `pnpm lint`).
- Linting and formatting use Biome (`pnpm lint`, `pnpm format`). Keep files Biome-clean.
- Target Node.js ≥ 20. Use ESM-compatible imports.
- Tests (Playwright) live under `apps/web/tests`.
- When introducing dependencies, add them at the correct workspace package and wire up exports through the relevant `index.ts`.

### Documentation & Change Management
- Update relevant MDX docs under `apps/web/content` when altering user-facing behavior.
- Log noteworthy changes in `CHANGELOG.md` if the tweak impacts consumers.
- Keep commit messages concise and conventional (`feat:`, `fix:`, etc.) if you prepare commits.

### When in Doubt
- Inspect neighboring files for patterns before writing new code.
- Ask for clarification on product requirements rather than guessing.
- Prefer incremental, well-scoped changes over sweeping rewrites.
- Ensure any new feature has a corresponding server and client story (UI, API, data layer, emails if needed).


