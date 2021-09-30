const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const MatchSchema = new mongoose.Schema({
  firstLikedUser: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  secondLikedUser: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  firstUserPlant: {
    _id: {
      type: mongoose.Schema.Types.ObjectId,
    },
    type: {
      type: String,
    },
  },
  secondUserPlant: {
    _id: {
      type: mongoose.Schema.Types.ObjectId,
    },
    type: {
      type: String,
    },
  },
  matched: {
    type: Boolean,
    default: false,
  },
});
module.exports = Plant = mongoose.model("match", MatchSchema);
