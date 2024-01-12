const reactionValidator = {
  add: (json) => {
    const { reaction, messageId } = json;
    if (!reaction || reaction.trim() === "") return "Reaction is required";
    if (!messageId || messageId.trim() === "") return "Message id is required";

    return undefined;
  },
  remove: (json) => {
    const { reactionId, messageId } = json;
    if (!reactionId || reactionId.trim() === "")
      return "Reaction id is required";
    if (!messageId || messageId.trim() === "") return "Message id is required";

    return undefined;
  },
};

export default reactionValidator;
