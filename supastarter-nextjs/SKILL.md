---
name: supastarter-nextjs
description: "Expert guidance for working with the supastarter Next.js SaaS starter kit. Use this skill when users mention supastarter, want to build a SaaS application, need help with Next.js boilerplate setup, ask about authentication/billing/multi-tenancy implementation, request help understanding the supastarter codebase structure, or need to write code following supastarter conventions. Triggers on queries about supastarter features, customization, configuration, building new features, troubleshooting, code generation, or any supastarter-related development tasks. IMPORTANT: Always read references/coding-conventions.md before writing any code."
---

# supastarter for Next.js - Development Guide

Expert guidance for building production-ready SaaS applications with the supastarter Next.js starter kit.

## Overview

supastarter is a production-ready SaaS starter kit built on Next.js 14+ that includes authentication, billing, multi-tenancy, admin panels, internationalization, and comprehensive developer tooling. It uses a monorepo structure (TurboRepo) to organize features and enable code sharing across packages.

## Tech Stack

**Core Framework:**
- Next.js 14+ (App Router & Route Handlers for API)
- React 18+
- TypeScript

**Backend & Data:**
- Prisma ORM (type-safe database access)
- Hono.js (lightweight backend API framework)
- PostgreSQL (recommended database)

**Authentication & Payments:**
- better-auth (modern auth for TypeScript apps)
- Stripe / Lemonsqueezy / Polar (payment providers)

**UI & Styling:**
- Tailwind CSS 3.4+
- Radix UI / shadcn/ui (accessible components)

**Additional Tools:**
- TurboRepo (monorepo management)
- TanStack Query (data fetching & caching)
- Vercel AI SDK (optional, for AI features)
- content-collections (markdown-based CMS for blog/docs)

## Project Structure

```
supastarter-project/
├── apps/
│   └── web/              # Main Next.js application
│       ├── app/          # App Router pages & routes
│       ├── components/   # React components
│       ├── config/       # Configuration files
│       └── lib/          # Utility functions
├── packages/
│   ├── api/              # Backend API (Hono.js)
│   ├── database/         # Prisma schema & migrations
│   ├── ui/               # Shared UI components
│   └── config/           # Shared configuration
└── turbo.json            # TurboRepo configuration
```

## Key Features & Implementation Patterns

### 1. Authentication

supastarter uses **better-auth** for authentication. Common patterns:

**Sign-up/Login:**
- Password-based authentication
- Magic link authentication
- OAuth providers (Google, GitHub, etc.)
- Email verification flows

**Session Management:**
- Server-side session validation
- Client-side session hooks
- Protected routes with middleware

**Example implementation locations:**
- Auth configuration: `packages/api/src/auth/`
- Auth routes: `apps/web/app/(auth)/`
- Auth components: `apps/web/components/auth/`

### 2. Multi-Tenancy (Organizations)

Organizations allow multiple users to collaborate within shared workspaces.

**Key concepts:**
- User can belong to multiple organizations
- Role-based access control (owner, admin, member)
- Seat-based billing per organization
- Organization switching

**Implementation:**
- Database schema: `packages/database/prisma/schema.prisma`
- Organization context: Check for organization provider/context
- Organization routes: `apps/web/app/(app)/[organizationSlug]/`

### 3. Billing & Subscriptions

Integrated payment processing with multiple providers.

**Supported patterns:**
- Subscription plans (monthly/yearly)
- Seat-based billing (pay per user)
- Usage-based billing
- One-time payments

**Webhook handling:**
- Payment events processed via API routes
- Subscription status updates
- Invoice generation

**Locations:**
- Payment config: `apps/web/config/payment.ts`
- Webhook handlers: `packages/api/src/webhooks/`
- Billing UI: `apps/web/app/(app)/settings/billing/`

### 4. Admin Panel

Super admin functionality for managing users and organizations.

**Features:**
- User management (list, impersonate, suspend)
- Organization management
- Analytics & metrics
- User impersonation (for support)

**Access:**
- Admin routes: `apps/web/app/(admin)/`
- Admin middleware for access control

### 5. Internationalization (i18n)

Built-in support for multiple languages.

**Implementation:**
- Translation files: `apps/web/locales/`
- Language detection & switching
- Localized routing
- Date/currency formatting

### 6. Database & ORM (Prisma)

**Schema management:**
```bash
# Create migration
pnpm db:migrate

# Generate Prisma Client
pnpm db:generate

# Open Prisma Studio
pnpm db:studio
```

**Common patterns:**
- Define models in `schema.prisma`
- Use generated types for type safety
- Implement relations (user → organizations → subscriptions)

### 7. API Development (Hono.js)

The API layer is separate from Next.js for better organization.

**Creating new endpoints:**
```typescript
// packages/api/src/routes/your-feature.ts
import { Hono } from 'hono'

const app = new Hono()

app.get('/endpoint', async (c) => {
  // Your logic
  return c.json({ data: 'result' })
})

export default app
```

**Key patterns:**
- Type-safe routes with Hono
- Middleware for auth, validation
- Error handling
- Response formatting

## Common Development Tasks

### Building a New Feature

**Step-by-step workflow:**

1. **Database Schema** (if needed)
   - Add models to `packages/database/prisma/schema.prisma`
   - Run `pnpm db:migrate` to create migration
   - Run `pnpm db:generate` to update Prisma Client

2. **API Endpoints** (if needed)
   - Create route in `packages/api/src/routes/`
   - Add authentication/authorization
   - Register route in main API app

3. **UI Components**
   - Create components in `apps/web/components/`
   - Use shadcn/ui for consistent styling
   - Implement data fetching with TanStack Query

4. **Pages/Routes**
   - Add pages in `apps/web/app/`
   - Use App Router conventions
   - Implement loading/error states

5. **Testing**
   - Write unit tests for business logic
   - Test API endpoints
   - Verify UI interactions

### Customizing the UI

**Theme customization:**
- Tailwind config: `apps/web/tailwind.config.ts`
- CSS variables: `apps/web/app/globals.css`
- Component variants: Override shadcn/ui components

**Brand assets:**
- Logo: `apps/web/public/`
- Favicons: `apps/web/app/favicon.ico`
- Metadata: Update in layout files

### Configuration

**Environment variables:**
```bash
# Database
DATABASE_URL="postgresql://..."

# Auth
AUTH_SECRET="..."
NEXT_PUBLIC_APP_URL="http://localhost:3000"

# Payment provider
STRIPE_SECRET_KEY="..."
STRIPE_WEBHOOK_SECRET="..."

# Storage (optional)
S3_BUCKET="..."
```

**App configuration:**
- Site metadata: `apps/web/config/site.ts`
- Payment plans: `apps/web/config/payment.ts`
- Feature flags: `apps/web/config/features.ts`

## Development Workflow

**Local development:**
```bash
# Install dependencies
pnpm install

# Setup database
pnpm db:push

# Start dev server
pnpm dev
```

**Common commands:**
```bash
# Run all apps
pnpm dev

# Run specific app
pnpm dev --filter=web

# Build for production
pnpm build

# Lint & format
pnpm lint
pnpm format
```

## Deployment

**Recommended platforms:**
- Vercel (Next.js optimized)
- Netlify
- Railway
- Self-hosted with Docker

**Database hosting:**
- Neon (serverless Postgres)
- Supabase
- PlanetScale
- AWS RDS

**Pre-deployment checklist:**
- Set environment variables
- Run database migrations
- Configure webhooks for payment provider
- Set up domain & SSL
- Configure CORS if needed

## Troubleshooting Common Issues

**Database connection errors:**
- Verify DATABASE_URL format
- Check database is running
- Ensure migrations are applied

**Authentication issues:**
- Verify AUTH_SECRET is set
- Check callback URLs match
- Ensure session cookie settings are correct

**Payment webhook failures:**
- Verify webhook secret matches
- Check webhook endpoint is accessible
- Review webhook logs in provider dashboard

**Build errors:**
- Clear `.next` and `node_modules`
- Regenerate Prisma Client
- Check for TypeScript errors

## Coding Conventions & Style Guide

When writing code for supastarter projects, **always follow the established conventions**. These are documented in detail in `references/coding-conventions.md`. Key highlights:

**Architecture:**
- Frontend: `apps/web/app` (Next.js App Router)
- Shared modules: `apps/web/modules`
- Backend: `packages/*` (api, auth, database, etc.)
- Use package exports (`@repo/api`) instead of relative imports

**Code Style:**
- TypeScript everywhere; interfaces over type aliases
- Named function exports for React components
- Avoid enums; use maps/records or union literals
- camelCase for variables, kebab-case for directories
- Pure functions with `function` keyword

**React Patterns:**
- Prefer Server Components by default
- Only use `"use client"` when necessary
- Wrap client components in `Suspense`
- Colocate route-specific helpers
- Use `notFound()`, `redirect()` for error handling

**Forms & Validation:**
- react-hook-form for all forms
- zod for schema validation
- Reuse existing form abstractions

**API & Data:**
- Add API logic to `@repo/api` package
- Group in `packages/api/modules`
- Use clients from `@repo/database`
- Never instantiate Prisma/Drizzle directly

**Tooling:**
- pnpm as package manager
- Biome for linting/formatting
- Turbo for monorepo tasks
- Node.js ≥ 20, ESM imports

**Before writing any code, read `references/coding-conventions.md` for complete guidelines.**

## Best Practices

1. **Mirror existing patterns** - Check adjacent files before creating new patterns
2. **Type safety** - Leverage TypeScript and Prisma's generated types
3. **Database transactions** - Use Prisma transactions for data consistency
4. **Error handling** - Use Next.js error boundaries and proper error responses
5. **Security** - Validate inputs, sanitize data, use environment variables for secrets
6. **Performance** - Server Components by default, optimize images, implement caching
7. **Testing** - Write Playwright tests for critical user flows
8. **Incremental changes** - Prefer small, scoped changes over large rewrites

## Getting Help

**Official resources:**
- Documentation: https://supastarter.dev/docs/nextjs
- Discord community (post-purchase access)
- Example features in the codebase
- Blog posts with guides: https://supastarter.dev/blog

**Skill resources:**
- `references/coding-conventions.md` - **READ THIS FIRST before writing code** - Complete coding style guide and architectural patterns
- `references/code-patterns.md` - Copy-paste ready code examples for common tasks
- `references/quick-reference.md` - Command cheat sheet and troubleshooting guide

**When asking for help:**
- Describe what you're trying to build
- Share relevant code snippets
- Include error messages
- Mention which features/packages are involved
