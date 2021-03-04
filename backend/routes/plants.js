var express = require("express");
var router = express.Router();
const User = require("../models/userModel");
const Plant = require("../models/plantModel");
const Preference = require("../models/preferenceModel");

router.get("/swipe-deck/:id", async function (req, res, next) {
    var id = req.params.id;
    var preference = await Preference.find({user: id});
    res.json(plants);
});


/* GET all plants from a user */
router.get("/:id", async function (req, res, next) {
  var id = req.params.id;
  var plants = await Plant.find({ user: id });
  res.json(plants);
});

router.post("/add-plant", async function (req, res, next) {
  var form = req.body;
  var userId = form.id;
  try {
    let user = await User.findById(userId);
    if (user) {

    const newPlant = new Plant({
      user: userId,
      title: form.title,
      desc: form.desc,
      pic: form.pic,
      type: form.type,
    });

    await newPlant.save();
    res.send(newPlant);
    }
    else {
    res.send("User doesn't exist")
    }
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ message: "Server error" });
  }
});
module.exports = router;
