import { z } from "zod";

const nameSchema = z
  .string()
  .trim()
  .min(1, "Name is required")
  .min(3, "Name is too short");

const emailSchema = z
  .string()
  .trim()
  .min(1, "Email is required")
  .refine((val) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val), {
    message: "Invalid email",
  });

const passwordSchema = z
  .string()
  .trim()
  .min(1, "Password is required")
  .min(5, "Password must have 5 to 15 char")
  .max(15, "Password must have 5 to 15 char")
  .regex(
    /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,15}$/,
    "Password must have 5 to 15 char and at least 1 uppercase, lowercase, numeric digit"
  );

export const registerSchema = z.object({
  body: z.object({
    name: nameSchema,
    email: emailSchema,
    password: passwordSchema,
  }),
});

export const loginSchema = z.object({
  body: z.object({
    email: emailSchema,
    password: z.string().trim().min(1, "Password is required"),
  }),
});

export const changePasswordSchema = z.object({
  body: z
    .object({
      oldPassword: z.string().trim().min(1, "Old password is required"),
      password: z.string().trim().min(1, "Password is required"), // Use generic password requirement or same constraint? Original validator didn't enforce regex on new password, but it should. Assuming basic check as per original for now or safer to imply strong password. Original: just required.
      confirmPassword: z.string().trim().min(1, "Confirm password is required"),
    })
    .refine((data: any) => data.password === data.confirmPassword, {
      message: "Password and confirm password did not match",
      path: ["confirmPassword"],
    }),
});

export const requestRefreshTokenSchema = z.object({
  body: z.object({
    refreshToken: z.string().min(1, "Refresh token required"),
  }),
});

export const changeNameSchema = z.object({
  body: z.object({
    name: nameSchema,
  }),
});

// Search handled via query or body in controller, unifying to body per old validator or query?
// Original: const query = (req.query.query as string) || req.body.name;
// We can support both schema if needed, or stick to one.
// Let's support both for backward compatibility if needed, or strictly one.
// The old controller used: req.query.query || req.body.name.
export const searchUserSchema = z
  .object({
    body: z.object({
      name: z.string().optional(),
    }),
    query: z
      .object({
        query: z.string().optional(),
      })
      .optional(),
  })
  .refine((data: any) => data.body.name || data.query?.query, {
    message: "Query is required",
    path: ["body", "name"], // Highlight one
  });
