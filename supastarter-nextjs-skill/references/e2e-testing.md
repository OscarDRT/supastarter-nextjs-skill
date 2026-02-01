# E2E Testing (Next.js)

E2E tests in supastarter Next.js.

## Patterns

- **Runner**: Playwright (or Cypress) per project; config at root or under `apps/web/`.
- **Tests**: Critical user flows (auth, onboarding, billing, feedback); place tests in `apps/web/tests/` or `e2e/` per docs.
- **Run**: `pnpm test:e2e` or `pnpm exec playwright test` (or equivalent from root or app).

## Key Paths

- Tests: `apps/web/tests/` or `apps/web/e2e/`
- Config: `playwright.config.ts` (root or app)

## Docs

- [E2E testing](https://supastarter.dev/docs/nextjs/e2e)
