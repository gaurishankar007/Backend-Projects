const memberValidator = {
  add: (json) => {
    const { chatId, userIds } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!userIds || userIds.length === 0) return "Users id are required";

    return undefined;
  },
  remove: (json) => {
    const { chatId, memberId } = json;
    if (!chatId || chatId.trim() === "") return "Chat id is required";
    if (!memberId || memberId.trim() === "") return "Member id is required";

    return undefined;
  },
};

export default memberValidator;
