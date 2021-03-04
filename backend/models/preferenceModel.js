const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const PreferenceSchema = new mongoose.Schema({
    distance: {
      type: Number,
    },
    types: {
      type: [String],
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
    } 
  });

module.exports = Preference = mongoose.model("preferences", PreferenceSchema);