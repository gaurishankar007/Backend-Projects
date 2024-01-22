const messageValidator = {
  text: (json) => {
    const { chatId, content, contentType } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!content || content.trim() === "") return "Message is required";
    if (!contentType || contentType.trim() === "")
      return "Content type is required";

    return undefined;
  },
  replyText: (json) => {
    const { chatId, messageId, content, contentType } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!messageId || messageId.trim() === "") return "Message id is required";
    if (!content || content.trim() === "") return "Message is required";
    if (!contentType || contentType.trim() === "")
      return "Content type is required";

    return undefined;
  },
  file: (json) => {
    const { chatId, contentType } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!contentType || contentType.trim() === "")
      return "Content type is required";

    return undefined;
  },
  replyFile: (json) => {
    const { chatId, messageId, contentType } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!messageId || messageId.trim() === "") return "Message id is required";
    if (!contentType || contentType.trim() === "")
      return "Content type is required";

    return undefined;
  },
  fetch: (json) => {
    const { chatId, page } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!page) return "Page is required";
    if (!Number.isInteger(page)) return "Page must be integer";

    return undefined;
  },
};

export default messageValidator;
