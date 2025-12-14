const chatValidator = {
  addMember: (json: any) => {
    const { chatId, userIds } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!userIds || userIds.length === 0) return "Users id are required";

    return undefined;
  },
  removeMember: (json: any) => {
    const { chatId, userId } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!userId || userId.trim() === "") return "User id is required";

    return undefined;
  },
};

export default chatValidator;
