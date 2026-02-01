# Common supastarter Code Patterns

This reference contains frequently used code patterns and examples for building features in supastarter (Next.js). For oRPC-specific patterns see [api-patterns.md](api-patterns.md).

## Database Patterns (Prisma)

### Creating a New Model

```prisma
// packages/database/prisma/schema.prisma

model YourFeature {
  id        String   @id @default(cuid())
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  
  // Relations
  userId         String
  user           User   @relation(fields: [userId], references: [id], onDelete: Cascade)
  
  organizationId String?
  organization   Organization? @relation(fields: [organizationId], references: [id], onDelete: Cascade)
  
  // Fields
  title       String
  description String?
  status      FeatureStatus @default(ACTIVE)
  
  @@index([userId])
  @@index([organizationId])
}

enum FeatureStatus {
  ACTIVE
  INACTIVE
  ARCHIVED
}
```

### Query Patterns

```typescript
import { db } from "@repo/database";

// Find with relations
const item = await db.yourFeature.findUnique({
  where: { id },
  include: {
    user: true,
    organization: true,
  },
});

// Find many with filters
const items = await db.yourFeature.findMany({
  where: {
    organizationId,
    status: "ACTIVE",
  },
  orderBy: { createdAt: "desc" },
  take: 10,
});

// Create with transaction
await db.$transaction(async (tx) => {
  const feature = await tx.yourFeature.create({
    data: {
      title,
      userId,
      organizationId,
    },
  });
  return feature;
});
```

## API Patterns (Hono / oRPC)

For oRPC procedures (recommended in supastarter Next.js), see [api-patterns.md](api-patterns.md) and [assets/recipes/feedback-widget.md](../assets/recipes/feedback-widget.md). Below: plain Hono route style if the project uses it.

### Basic Hono Route Setup

```typescript
// packages/api/src/routes/features.ts
import { Hono } from "hono";
import { zValidator } from "@hono/zod-validator";
import { z } from "zod";

const app = new Hono();

const createSchema = z.object({
  title: z.string().min(1).max(100),
  description: z.string().optional(),
});

app.post("/", zValidator("json", createSchema), async (c) => {
  const { title, description } = c.req.valid("json");
  const userId = c.get("userId");
  const organizationId = c.get("organizationId");
  // create via @repo/database
  return c.json({ feature: {} }, 201);
});

export default app;
```

## Frontend Patterns (Next.js)

### Server Component with Data Fetching

```typescript
// apps/web/app/(app)/[organizationSlug]/features/page.tsx
import { db } from "@repo/database";
import { getCurrentUser } from "@repo/auth";
import { FeatureList } from "@modules/.../feature-list";

export default async function FeaturesPage({
  params,
}: {
  params: { organizationSlug: string };
}) {
  const user = await getCurrentUser();
  const organization = await db.organization.findUnique({
    where: { slug: params.organizationSlug },
  });
  if (!organization) notFound();

  const features = await db.yourFeature.findMany({
    where: { organizationId: organization.id },
    orderBy: { createdAt: "desc" },
  });

  return (
    <div>
      <h1>Features</h1>
      <FeatureList features={features} />
    </div>
  );
}
```

### Client Component with TanStack Query + oRPC

Use the project’s oRPC client (e.g. `orpc` from `@shared/lib/orpc-query-utils`):

```typescript
// apps/web/components/features/feature-list.tsx
"use client";

import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { orpc } from "@shared/lib/orpc-query-utils";

export function FeatureList() {
  const queryClient = useQueryClient();
  const { data, isLoading } = useQuery(orpc.features.list.queryOptions());
  const createMutation = useMutation(orpc.features.create.mutationOptions());

  const onCreate = () => {
    createMutation.mutate(
      { input: { title: "New" } },
      {
        onSuccess: () => queryClient.invalidateQueries({ queryKey: ["features"] }),
      }
    );
  };

  if (isLoading) return <div>Loading...</div>;
  return (
    <div>
      {data?.items?.map((f) => (
        <div key={f.id}>{f.title}</div>
      ))}
      <button onClick={onCreate}>Create</button>
    </div>
  );
}
```

### Form with react-hook-form + zod

```typescript
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";

const schema = z.object({ title: z.string().min(1) });
type FormValues = z.infer<typeof schema>;

export function FeatureForm() {
  const form = useForm<FormValues>({
    resolver: zodResolver(schema),
    defaultValues: { title: "" },
  });
  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit((data) => { /* submit */ })}>
        <FormField control={form.control} name="title" render={({ field }) => (
          <FormItem>
            <FormLabel>Title</FormLabel>
            <FormControl><Input {...field} /></FormControl>
            <FormMessage />
          </FormItem>
        )} />
        <Button type="submit">Submit</Button>
      </form>
    </Form>
  );
}
```

## UI Components (shadcn/ui)

### Using Built-in Components

```typescript
import { Button } from "@ui/components/button";
import { Card, CardContent, CardHeader, CardTitle } from "@ui/components/card";
import { Input } from "@ui/components/input";
import { Label } from "@ui/components/label";

export function FeatureCard() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Create Feature</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          <div>
            <Label htmlFor="title">Title</Label>
            <Input id="title" name="title" />
          </div>
          <Button type="submit">Submit</Button>
        </div>
      </CardContent>
    </Card>
  );
}
```

## Authentication Patterns

### Getting Current User (server)

```typescript
import { auth } from "@repo/auth";
import { headers } from "next/headers";
import { redirect } from "next/navigation";

export async function getCurrentUser() {
  const session = await auth.api.getSession({
    headers: await headers(),
  });
  if (!session) redirect("/login");
  return session.user;
}
```

### Protecting Routes (middleware)

Use the project’s auth middleware; ensure organization access is checked when using `[organizationSlug]` routes. See [auth-patterns.md](auth-patterns.md).

## Organization Patterns

### Organization Context (client)

```typescript
"use client";

import { createContext, useContext } from "react";
import type { Organization } from "@repo/database";

const OrganizationContext = createContext<Organization | null>(null);

export function useOrganization() {
  const context = useContext(OrganizationContext);
  if (!context) throw new Error("useOrganization must be used within OrganizationProvider");
  return context;
}
```

### Role-Based Access Control

Use maps or union literals instead of enums (per [coding-conventions.md](coding-conventions.md)):

```typescript
const OrganizationRole = {
  OWNER: "OWNER",
  ADMIN: "ADMIN",
  MEMBER: "MEMBER",
} as const;

export function canManageMembers(role: string) {
  return role === OrganizationRole.OWNER || role === OrganizationRole.ADMIN;
}
```

## Docs

- [API patterns (oRPC)](api-patterns.md)
- [Feedback widget recipe](../assets/recipes/feedback-widget.md)
- [supastarter Next.js docs](https://supastarter.dev/docs/nextjs)
