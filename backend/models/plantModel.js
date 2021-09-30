const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const PlantSchema = new mongoose.Schema({
  user: {
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
  pic: {
    type: [String],
    required: true,
  },
  type: {
    type: String,
  },
});
module.exports = Plant = mongoose.model("plants", PlantSchema);
