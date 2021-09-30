const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const MySwipeHistoryModel = new mongoose.Schema({
  myUserID: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  userID: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  plantID: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  title: {
    type: String,
    required: true,
  },
  desc: {
    type: String,
  },
  type: {
    type: String,
  },
  matched: {
    type: Boolean,
    default: false,
  },
});
module.exports = MySwipeHistory = mongoose.model(
  "mySwipeHistory",
  MySwipeHistoryModel
);
