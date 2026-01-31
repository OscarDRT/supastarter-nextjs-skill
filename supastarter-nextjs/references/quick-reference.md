# supastarter Quick Reference

Quick reference for common supastarter development tasks and commands.

## Initial Setup

```bash
# Clone your supastarter project
git clone <your-repo>
cd supastarter-project

# Install dependencies
pnpm install

# Copy environment variables
cp .env.example .env

# Configure your .env file with:
# - DATABASE_URL
# - AUTH_SECRET
# - Payment provider keys
# - Storage credentials (if using)

# Push database schema
pnpm db:push

# Start development server
pnpm dev
```

## Common Commands

### Development
```bash
# Start all apps
pnpm dev

# Start specific app only
pnpm dev --filter=web

# Build for production
pnpm build

# Type check
pnpm type-check

# Lint code
pnpm lint

# Format code
pnpm format
```

### Database (Prisma)
```bash
# Generate Prisma Client
pnpm db:generate

# Create migration
pnpm db:migrate

# Push schema without migration (dev only)
pnpm db:push

# Open Prisma Studio (database GUI)
pnpm db:studio

# Reset database (WARNING: deletes all data)
pnpm db:reset
```

### Testing
```bash
# Run all tests
pnpm test

# Run tests in watch mode
pnpm test:watch

# Run tests with coverage
pnpm test:coverage
```

## File Locations Cheat Sheet

### Configuration
- Environment variables: `.env`
- Site metadata: `apps/web/config/site.ts`
- Payment plans: `apps/web/config/payment.ts`
- Tailwind config: `apps/web/tailwind.config.ts`

### Database
- Schema: `packages/database/prisma/schema.prisma`
- Migrations: `packages/database/prisma/migrations/`

### API Routes
- Hono routes: `packages/api/src/routes/`
- Main API app: `packages/api/src/index.ts`

### Frontend
- Pages: `apps/web/app/`
- Components: `apps/web/components/`
- UI components: `apps/web/components/ui/`
- Layouts: `apps/web/app/layout.tsx`

### Authentication
- Auth config: `packages/api/src/auth/` or `apps/web/lib/auth.ts`
- Auth pages: `apps/web/app/(auth)/`

### Organization Routes
- Organization pages: `apps/web/app/(app)/[organizationSlug]/`
- Organization settings: `apps/web/app/(app)/[organizationSlug]/settings/`

### Admin
- Admin pages: `apps/web/app/(admin)/`

## Environment Variables Template

```env
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/dbname"

# Auth
AUTH_SECRET="your-secret-key-here"
NEXT_PUBLIC_APP_URL="http://localhost:3000"

# Stripe (if using)
STRIPE_SECRET_KEY="sk_test_..."
STRIPE_PUBLISHABLE_KEY="pk_test_..."
STRIPE_WEBHOOK_SECRET="whsec_..."

# Lemonsqueezy (if using)
LEMONSQUEEZY_API_KEY="..."
LEMONSQUEEZY_STORE_ID="..."
LEMONSQUEEZY_WEBHOOK_SECRET="..."

# Email (if using)
SMTP_HOST="smtp.example.com"
SMTP_PORT="587"
SMTP_USER="..."
SMTP_PASSWORD="..."

# Storage (if using S3)
S3_BUCKET="your-bucket"
S3_REGION="us-east-1"
S3_ACCESS_KEY="..."
S3_SECRET_KEY="..."
```

## Quick Troubleshooting

### "Cannot find module '@/...'"
- Run `pnpm install` to ensure all dependencies are installed
- Check if TypeScript paths are configured in `tsconfig.json`

### Database connection errors
- Verify `DATABASE_URL` is correct in `.env`
- Ensure PostgreSQL is running
- Try `pnpm db:push` to sync schema

### "Prisma Client not generated"
- Run `pnpm db:generate`
- Restart your dev server

### Build errors
```bash
# Clean and rebuild
rm -rf .next node_modules
pnpm install
pnpm build
```

### Type errors after schema changes
```bash
# Regenerate Prisma types
pnpm db:generate

# Restart TypeScript server in your IDE
```

## Common Modifications

### Adding a new page
1. Create file in `apps/web/app/` following Next.js App Router conventions
2. Use Server Components by default
3. Use `'use client'` only when needed (forms, interactive elements)

### Adding a new API endpoint
1. Create route file in `packages/api/src/routes/`
2. Export Hono app instance
3. Register in `packages/api/src/index.ts`
4. Add authentication middleware if needed

### Adding a new database model
1. Add model to `packages/database/prisma/schema.prisma`
2. Run `pnpm db:migrate` (production) or `pnpm db:push` (dev)
3. Run `pnpm db:generate` to update Prisma Client
4. Restart dev server

### Customizing UI theme
1. Edit `apps/web/tailwind.config.ts` for Tailwind customization
2. Edit `apps/web/app/globals.css` for CSS variables
3. Override shadcn/ui components in `apps/web/components/ui/`

## Production Deployment Checklist

- [ ] Set all environment variables in production
- [ ] Run database migrations: `pnpm db:migrate`
- [ ] Configure payment provider webhooks
- [ ] Set up domain and SSL certificate
- [ ] Configure CORS if needed
- [ ] Set up monitoring (Sentry, LogRocket, etc.)
- [ ] Test authentication flows
- [ ] Test payment flows (use test mode first)
- [ ] Configure email service
- [ ] Set up backups for database
- [ ] Review security headers
- [ ] Enable rate limiting if needed

## Resources

- Official docs: https://supastarter.dev/docs/nextjs
- Discord: Available after purchase
- Next.js docs: https://nextjs.org/docs
- Prisma docs: https://www.prisma.io/docs
- Hono docs: https://hono.dev
- shadcn/ui: https://ui.shadcn.com
