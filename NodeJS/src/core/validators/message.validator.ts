const messageValidator = {
  text: (json: any) => {
    const { chatId, content, contentType } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!content || content.trim() === "") return "Message is required";
    if (!contentType || contentType.trim() === "")
      return "Content type is required";

    return undefined;
  },
  replyText: (json: any) => {
    const { chatId, messageId, content, contentType } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!messageId || messageId.trim() === "") return "Message id is required";
    if (!content || content.trim() === "") return "Message is required";
    if (!contentType || contentType.trim() === "")
      return "Content type is required";

    return undefined;
  },
  file: (json: any) => {
    const { chatId, contentType } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!contentType || contentType.trim() === "")
      return "Content type is required";

    return undefined;
  },
  replyFile: (json: any) => {
    const { chatId, messageId, contentType } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!messageId || messageId.trim() === "") return "Message id is required";
    if (!contentType || contentType.trim() === "")
      return "Content type is required";

    return undefined;
  },
  react: (json: any) => {
    const { reaction, messageId } = json;
    if (!reaction || reaction.trim() === "") return "Reaction is required";
    if (!messageId || messageId.trim() === "") return "Message id is required";

    return undefined;
  },
  removeReaction: (json: any) => {
    const { reactionId, messageId } = json;
    if (!reactionId || reactionId.trim() === "")
      return "Reaction id is required";
    if (!messageId || messageId.trim() === "") return "Message id is required";

    return undefined;
  },
  fetch: (json: any) => {
    const { chatId, page } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!page) return "Page is required";
    if (!Number.isInteger(page)) return "Page must be integer";

    return undefined;
  },
};

export default messageValidator;
