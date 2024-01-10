const messageValidator = {
  sendText: (json) => {
    const { chatId, content } = json;
    if (!chatId || chatId === "") return "Chat id is required";
    if (!content || content === "") return "Message is required";

    return undefined;
  },
};

export default messageValidator;