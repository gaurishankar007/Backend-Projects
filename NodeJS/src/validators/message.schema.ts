import { z } from "zod";

const chatIdSchema = z.string().trim().min(1, "Chat id is required");
const messageIdSchema = z.string().trim().min(1, "Message id is required");
const contentSchema = z.string().trim().min(1, "Message is required");
const contentTypeSchema = z.string().trim().min(1, "Content type is required");

export const sendMessageSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    content: contentSchema,
    contentType: contentTypeSchema,
  }),
});

export const replyMessageSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    messageId: messageIdSchema,
    content: contentSchema,
    contentType: contentTypeSchema,
  }),
});

export const sendFileSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    contentType: contentTypeSchema,
  }),
});

export const replyFileSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    messageId: messageIdSchema,
    contentType: contentTypeSchema,
  }),
});

export const reactMessageSchema = z.object({
  body: z.object({
    messageId: messageIdSchema,
    reaction: z.string().trim().min(1, "Reaction is required"),
  }),
});

export const removeReactionSchema = z.object({
  body: z.object({
    messageId: messageIdSchema,
    reactionId: z.string().trim().min(1, "Reaction id is required"),
  }),
});

export const fetchMessageSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    page: z.number().int("Page must be integer"),
  }),
});
