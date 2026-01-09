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

export const sendFileSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    contentType: contentTypeSchema,
  }),
});

export const fetchMessageSchema = z.object({
  body: z.object({
    chatId: chatIdSchema,
    page: z.number().int("Page must be integer"),
  }),
});

export const deleteMessageSchema = z.object({
  body: z.object({
    messageId: messageIdSchema,
  }),
});
