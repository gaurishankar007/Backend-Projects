const messageValidator = {
  text: (json) => {
    const { chatId, content, contentType } = json;
    if (!chatId || chatId === "") return "Chat id is required";
    if (!content || content === "") return "Message is required";
    if (!contentType || contentType === "") return "Content type is required";

    return undefined;
  },
  replyText: (json) => {
    const { chatId, messageId, content, contentType } = json;
    if (!chatId || chatId === "") return "Chat id is required";
    if (!messageId || messageId === "") return "Message id is required";
    if (!content || content === "") return "Message is required";
    if (!contentType || contentType === "") return "Content type is required";

    return undefined;
  },
  file: (json) => {
    const { chatId, contentType } = json;
    if (!chatId || chatId === "") return "Chat id is required";
    if (!contentType || contentType === "") return "Content type is required";

    return undefined;
  },
  replyFile: (json) => {
    const { chatId, messageId, contentType } = json;
    if (!chatId || chatId === "") return "Chat id is required";
    if (!messageId || messageId === "") return "Message id is required";
    if (!contentType || contentType === "") return "Content type is required";

    return undefined;
  },
};

export default messageValidator;
