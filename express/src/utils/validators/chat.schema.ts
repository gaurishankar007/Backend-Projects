import { z } from "zod";

const userIdSchema = z.string().trim().min(1, "User id is required");
const chatIdSchema = z.string().trim().min(1, "Chat id is required");

export const createChatSchema = z.object({
  body: z.object({
    userId: userIdSchema,
  }),
});

export const createGroupSchema = z.object({
  body: z.object({
    name: z.string().optional(), // Original didn't enforce name? Original: const { userIds, name } = req.body;
    userIds: z.array(z.string()).min(2, "At least 2 users' id are required"),
  }),
});

export const addMemberSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    userIds: z.array(z.string()).min(1, "Users id are required"), // Original: usersId length check
  }),
});

export const removeMemberSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    userId: userIdSchema,
  }),
});

export const fetchChatSchema = z.object({
  body: z.object({
    page: z.number().int("Page must be integer"),
  }),
});
