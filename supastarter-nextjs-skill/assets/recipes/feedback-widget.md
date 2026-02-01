# Build a Feature: Feedback Widget (Next.js)

Full “build a feature” example for supastarter Next.js: database → queries → API (oRPC) → frontend → i18n → integration. Based on [Build a feature – feedback widget](https://supastarter.dev/docs/nextjs/recipes/build-a-feedback-widget).

## Overview

The feedback widget consists of:

1. **Database schema** – Prisma `Feedback` model and `User` relation
2. **Database queries** – `createFeedback` and exports
3. **API endpoint** – oRPC procedure (Zod, `publicProcedure`, optional session)
4. **Frontend component** – React form (shadcn, `useSession`, i18n, TanStack mutation)
5. **Translations** – en/de keys for feedback
6. **Integration** – Add `<FeedbackWidget />` to layout

---

## Step 1: Database Schema

Add a `Feedback` model and relation on `User` in the Prisma schema.

**File:** `packages/database/prisma/schema.prisma`

```prisma
model Feedback {
  id        String   @id @default(cuid())
  userId    String?
  user      User?    @relation(fields: [userId], references: [id], onDelete: SetNull)
  email     String?
  name      String?
  message   String
  type      String
  ipAddress String?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@map("feedback")
}

model User {
  // ... existing fields ...
  feedbacks Feedback[]
}
```

Then run:

```bash
pnpm --filter database push
# or: pnpm --filter database migrate dev
pnpm --filter database generate
```

---

## Step 2: Database Queries

Create query functions and export them.

**File:** `packages/database/prisma/queries/feedback.ts`

```ts
import { db } from "../client";

export async function createFeedback({
  message,
  type,
  email,
  name,
  ipAddress,
  userId,
}: {
  message: string;
  type: string;
  email?: string;
  name?: string;
  ipAddress?: string;
  userId?: string;
}) {
  return await db.feedback.create({
    data: {
      message,
      type,
      email,
      name,
      ipAddress,
      userId,
    },
  });
}
```

**File:** `packages/database/prisma/queries/index.ts`

Add:

```ts
export * from "./feedback";
```

(Keep existing exports like `./ai-chats`, `./organizations`, `./purchases`, `./users`.)

---

## Step 3: API Endpoint

Create the feedback oRPC module: types, procedure, router, then mount the router.

**File:** `packages/api/modules/feedback/types.ts`

```ts
import { z } from "zod";

export const feedbackSchema = z.object({
  message: z.string().min(10).max(1000),
  type: z.enum(["bug", "feature", "general"]).default("general"),
  email: z.string().email().optional(),
  name: z.string().min(2).max(100).optional(),
});

export type FeedbackFormValues = z.infer<typeof feedbackSchema>;
```

**File:** `packages/api/modules/feedback/procedures/create.ts`

```ts
import { ORPCError } from "@orpc/server";
import { auth } from "@repo/auth";
import { createFeedback } from "@repo/database";
import { logger } from "@repo/logs";
import { z } from "zod";
import { publicProcedure } from "../../orpc/procedures";
import { feedbackSchema } from "../types";

export const createFeedbackProcedure = publicProcedure
  .route({
    method: "POST",
    path: "/feedback",
    tags: ["Feedback"],
    summary: "Submit user feedback",
    description: "Submit feedback with optional contact information",
  })
  .input(feedbackSchema)
  .output(
    z.object({
      id: z.string(),
      message: z.string(),
    })
  )
  .handler(async ({ input, context }) => {
    try {
      const session = await auth.api.getSession({ headers: context.headers });
      const ipAddress =
        context.headers.get("x-forwarded-for") ||
        context.headers.get("x-real-ip") ||
        undefined;

      const feedback = await createFeedback({
        message: input.message,
        type: input.type,
        email: input.email,
        name: input.name,
        ipAddress,
        userId: session?.user.id,
      });

      return {
        id: feedback.id,
        message: "Feedback submitted successfully",
      };
    } catch (error) {
      logger.error("Failed to submit feedback:", error);
      throw new ORPCError("INTERNAL_SERVER_ERROR", {
        message: "Could not submit feedback",
      });
    }
  });
```

**File:** `packages/api/modules/feedback/router.ts`

```ts
import { createFeedbackProcedure } from "./procedures/create";

export const feedbackRouter = {
  create: createFeedbackProcedure,
};
```

**Mount in:** `packages/api/orpc/router.ts`

```ts
import { feedbackRouter } from "../modules/feedback/router";

export const router = publicProcedure
  .prefix("/api")
  .router({
    // ... other routers
    feedback: feedbackRouter,
  });
```

---

## Step 4: Frontend Component

React form with shadcn, `useSession`, i18n, and TanStack mutation.

**File:** `apps/web/modules/shared/components/FeedbackWidget.tsx`

```tsx
"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useSession } from "@saas/auth/hooks/use-session";
import { Button } from "@ui/components/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@ui/components/dialog";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@ui/components/form";
import { Input } from "@ui/components/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/select";
import { Textarea } from "@ui/components/textarea";
import { cn } from "@ui/lib";
import { MessageSquare } from "lucide-react";
import { useTranslations } from "next-intl";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { useMutation } from "@tanstack/react-query";
import { z } from "zod";
import { orpc } from "@shared/lib/orpc-query-utils";
import { toast } from "sonner";

const feedbackSchema = z.object({
  message: z.string().min(10).max(1000),
  type: z.enum(["bug", "feature", "general"]).default("general"),
  email: z.string().email().optional(),
  name: z.string().min(2).max(100).optional(),
});

type FeedbackFormValues = z.infer<typeof feedbackSchema>;

export function FeedbackWidget({ className }: { className?: string }) {
  const t = useTranslations();
  const { user } = useSession();
  const [isOpen, setIsOpen] = useState(false);
  const createFeedbackMutation = useMutation(orpc.feedback.create.mutationOptions());
  const form = useForm<FeedbackFormValues>({
    resolver: zodResolver(feedbackSchema),
    defaultValues: {
      message: "",
      type: "general",
      email: "",
      name: "",
    },
  });

  const onSubmit = async (data: FeedbackFormValues) => {
    try {
      await createFeedbackMutation.mutateAsync({ input: data });
      setIsOpen(false);
      form.reset();
      toast.success(t("feedback.success.message"));
    } catch (error) {
      console.error("Error submitting feedback:", error);
      toast.error(t("feedback.error.message"));
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={setIsOpen}>
      <DialogTrigger asChild>
        <Button
          variant="outline"
          size="sm"
          className={cn("fixed bottom-4 right-4 z-50 shadow-lg", className)}
        >
          <MessageSquare className="h-4 w-4 mr-2" />
          {t("feedback.button")}
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>{t("feedback.title")}</DialogTitle>
        </DialogHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
            <FormField
              control={form.control}
              name="type"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>{t("feedback.form.type.label")}</FormLabel>
                  <Select onValueChange={field.onChange} defaultValue={field.value}>
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder={t("feedback.form.type.placeholder")} />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      <SelectItem value="general">{t("feedback.form.type.options.general")}</SelectItem>
                      <SelectItem value="bug">{t("feedback.form.type.options.bug")}</SelectItem>
                      <SelectItem value="feature">{t("feedback.form.type.options.feature")}</SelectItem>
                    </SelectContent>
                  </Select>
                  <FormMessage />
                </FormItem>
              )}
            />
            {!user && (
              <>
                <FormField
                  control={form.control}
                  name="name"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>{t("feedback.form.name.label")}</FormLabel>
                      <FormControl>
                        <Input placeholder={t("feedback.form.name.placeholder")} {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="email"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>{t("feedback.form.email.label")}</FormLabel>
                      <FormControl>
                        <Input placeholder={t("feedback.form.email.placeholder")} {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </>
            )}
            <FormField
              control={form.control}
              name="message"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>{t("feedback.form.message.label")}</FormLabel>
                  <FormControl>
                    <Textarea
                      placeholder={t("feedback.form.message.placeholder")}
                      className="min-h-[100px]"
                      {...field}
                    />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <Button type="submit" className="w-full" disabled={createFeedbackMutation.isPending}>
              {t("feedback.form.submit")}
            </Button>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}
```

(Adjust imports like `@saas/auth/hooks/use-session`, `@ui/*`, `@shared/lib/orpc-query-utils` to match your repo.)

---

## Step 5: Translations

Add feedback keys to en and de.

**File:** `packages/i18n/translations/en.json`

Add under the root (or merge into existing):

```json
{
  "feedback": {
    "button": "Feedback",
    "title": "Send Feedback",
    "success": {
      "title": "Thank you!",
      "message": "Your feedback has been submitted successfully."
    },
    "error": {
      "title": "Error",
      "message": "Failed to submit feedback"
    },
    "form": {
      "type": {
        "label": "Feedback Type",
        "placeholder": "Select feedback type",
        "options": {
          "general": "General",
          "bug": "Bug Report",
          "feature": "Feature Request"
        }
      },
      "name": { "label": "Name", "placeholder": "Your name" },
      "email": { "label": "Email", "placeholder": "your.email@example.com" },
      "message": { "label": "Message", "placeholder": "Tell us what you think..." },
      "submit": "Send Feedback"
    }
  }
}
```

**File:** `packages/i18n/translations/de.json`

Add the same structure with German strings, e.g. `"button": "Feedback"`, `"title": "Feedback senden"`, etc.

---

## Step 6: Integration

Add the widget to a layout so it appears on the desired pages.

**File:** `apps/web/app/(marketing)/layout.tsx`

```tsx
import { FeedbackWidget } from "@modules/shared/components/FeedbackWidget";

export default function MarketingLayout({ children }: { children: React.ReactNode }) {
  return (
    <>
      {children}
      <FeedbackWidget />
    </>
  );
}
```

(Adjust import path to match your repo.)

---

## Summary

- **Schema:** `packages/database/prisma/schema.prisma` – `Feedback` model + `User.feedbacks`
- **Queries:** `packages/database/prisma/queries/feedback.ts` + export in `queries/index.ts`
- **API:** `packages/api/modules/feedback/` (types, procedures/create, router) + mount in `packages/api/orpc/router.ts`
- **UI:** `apps/web/modules/shared/components/FeedbackWidget.tsx` (form, session, i18n, mutation)
- **i18n:** `packages/i18n/translations/{en,de}.json` – `feedback.*`
- **Integration:** `<FeedbackWidget />` in `apps/web/app/(marketing)/layout.tsx`

For more, see [Build a feature – feedback widget](https://supastarter.dev/docs/nextjs/recipes/build-a-feedback-widget).
