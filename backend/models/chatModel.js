var mongoose = require("mongoose"),
  Schema = mongoose.Schema;

var ChatSchema = new mongoose.Schema({
  chatRoom: { type: Schema.Types.ObjectId, ref: "chatRoom" },
  fromID: mongoose.Schema.Types.ObjectId,
  message: String,
  picUrl: [String],
  created_date: { type: Date, default: Date.now },
  user1Viewed: {
    type: Boolean,
    default: true,
  },
  user2Viewed: {
    type: Boolean,
    default: true,
  },
});

module.exports = mongoose.model("Chat", ChatSchema);
