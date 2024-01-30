const chatVdr = {
  addMbr: (json) => {
    const { chatId, userIds } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!userIds || userIds.length === 0) return "Users id are required";

    return undefined;
  },
  removeMbr: (json) => {
    const { chatId, userId } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!userId || userId.trim() === "") return "User id is required";

    return undefined;
  },
};

export default chatVdr;
