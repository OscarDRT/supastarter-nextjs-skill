# Payments Patterns (Next.js)

Stripe, webhooks, and subscriptions in supastarter Next.js.

## Patterns

- **Config**: Payment provider and plans in `apps/web/config/payment.ts`.
- **Webhooks**: Handlers in `packages/api/src/webhooks/` (or equivalent); verify secret, process events, update subscription state.
- **Billing UI**: `apps/web/app/(app)/settings/billing/` (or under organization).
- **Plans / products**: Define in config and provider; check purchases via API or DB.

## Key Paths

- Payment config: `apps/web/config/payment.ts`
- Webhooks: `packages/api/src/webhooks/`
- Billing pages: `apps/web/app/(app)/settings/billing/`

## Docs

- [Payments overview](https://supastarter.dev/docs/nextjs/payments/overview)
- [Plans / products](https://supastarter.dev/docs/nextjs/payments/plans)
- [Check purchases](https://supastarter.dev/docs/nextjs/payments/check-purchases)
- [Paywall](https://supastarter.dev/docs/nextjs/payments/paywall)
