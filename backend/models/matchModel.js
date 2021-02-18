const mongoose = require("mongoose");
const Schema = mongoose.Schema;


const MatchSchema = new mongoose.Schema({
  firstLiked: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  likedPlant: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  matched: {
    type: Boolean,
    default: false,
  }
});
module.exports = Plant = mongoose.model("match", MatchSchema);