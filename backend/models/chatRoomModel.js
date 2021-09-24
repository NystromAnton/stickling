var mongoose = require("mongoose"),
  Schema = mongoose.Schema;

var chatRoomSchema = new mongoose.Schema({
  user1: mongoose.Schema.Types.ObjectId,
  user2: mongoose.Schema.Types.ObjectId,
  plant1: mongoose.Schema.Types.ObjectId,
  plant2: mongoose.Schema.Types.ObjectId,
  createdDate: { type: Date, default: Date.now },
});

module.exports = mongoose.model("chatRoom", chatRoomSchema);
