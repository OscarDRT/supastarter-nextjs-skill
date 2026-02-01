# Scripts

## generate_module.py

Scaffolds a new API module for supastarter Next.js (oRPC).

### Usage

Run from the **supastarter monorepo root** (where `packages/api` exists):

```bash
python scripts/generate_module.py <module-name>
```

### Arguments

- **module-name**: Lowercase, alphanumeric; hyphens allowed (e.g. `feedback`, `user-settings`).

### What it creates

Under `packages/api/modules/<name>/`:

- **types.ts** – Zod schema stub and inferred type.
- **procedures/create.ts** – `publicProcedure` create stub (POST); implement handler and wire to DB.
- **router.ts** – Router object exporting `create`.

### After running

1. Implement the create handler in `procedures/create.ts` (session, DB call from `@repo/database`).
2. Mount the router in `packages/api/orpc/router.ts`:

   ```ts
   import { <name>Router } from "../modules/<name>/router";
   // In the router object: <name>: <name>Router
   ```

### Example

```bash
python scripts/generate_module.py feedback
```

Creates `packages/api/modules/feedback/` with `types.ts`, `procedures/create.ts`, and `router.ts`. See [assets/recipes/feedback-widget.md](../assets/recipes/feedback-widget.md) for a full implementation.
