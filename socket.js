const socketFunction = (socket) => {
  socket.on("setup", (userData) => {
    const userId = userData.userId;
    const friends = userData.friends;

    socket.join(userId);
    for (const friend in friends) {
      socket.to(friend).emit("online", userData.userId);
    }
  });

  socket.on("join-chat", (chatId) => socket.join(chatId));

  socket.on("typing", (typeData) =>
    socket.to(typeData.chatId).emit("typing", typeData.typist)
  );

  socket.on("stop-typing", (typeData) =>
    socket.to(typeData.chatId).emit("stop-typing", typeData.typist)
  );

  socket.on("message", (messageData) => {
    socket.in(messageData.chatId).emit("message-received", messageData.message);
  });

  socket.on("message-seen", (seenData) =>
    socket.to(seenData.chatId).emit("message-seen", seenData.member)
  );

  socket.on("set-theme", (themeData) =>
    socket.to(themeData.chatId).emit("new-theme", themeData.theme)
  );

  socket.off("setup", () => {
    console.log(userData);
    socket.leave(userData.userId);
  });
};

export default socketFunction;
