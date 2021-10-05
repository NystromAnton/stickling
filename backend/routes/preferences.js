var express = require("express");
var router = express.Router();
const User = require("../models/userModel");
const Plant = require("../models/plantModel");
const Preference = require("../models/preferenceModel");

router.get("/:id", async function (req, res, next) {
  var id = req.params.id;
  var preference = await Preference.find({ user: id });
  res.json(preference);
});

router.post("/add-preference", async function (req, res, next) {
  var form = req.body;
  var userId = form.id;
  try {
    let user = await User.findById(userId);
    if (user) {
      var preference = await Preference.findOne({ user: userId });
      console.log(preference);
      if (preference) {
        var distanceMeters = form.distance*1000;
        var p = await Preference.findOneAndUpdate(
          { _id: preference._id },
          {
            $set: { types: form.types, distance: distanceMeters },
          }
        );
        console.log(p);
        res.send("Preference updated");
      } else {
        var distanceMeters = form.distance*1000;
        const newPreference = new Preference({
          user: userId,
          types: form.types,
          distance: distanceMeters,
        });

        await newPreference.save();
        res.send(newPreference);
      }
    } else {
      res.send("User doesn't exist");
    }
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ message: "Server error" });
  }
});
module.exports = router;
