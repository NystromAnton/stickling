var mongoose = require("mongoose"),
  Schema = mongoose.Schema;

var chatRoomSchema = new mongoose.Schema({
  user1ID: mongoose.Schema.Types.ObjectId,
  user2ID: mongoose.Schema.Types.ObjectId,
  plant1ID: mongoose.Schema.Types.ObjectId,
  plant2ID: mongoose.Schema.Types.ObjectId,
  createdDate: { type: Date, default: Date.now },
});

module.exports = mongoose.model("chatRoom", chatRoomSchema);
