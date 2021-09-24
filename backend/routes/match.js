var express = require("express");
var router = express.Router();
const User = require("../models/userModel");
const Plant = require("../models/plantModel");
const Match = require("../models/matchModel");

/* GET all plants from a user */
router.get("/:id", async function (req, res, next) {
  var id = req.params.id;
  var plants = await Plant.find({ user: id });
  res.json(plants);
});
router.post("/", async function (req, res, next) {
  var form = req.body;
  var userId = form.userId;
  var plantId = form.plantId;
  try {
    let user = await User.findById(userId);
    var plants = await Plant.find({ user: userId });
    var swipedPlant = await Plant.findById(plantId);
    if (user) {
      var match = await Match.find({
        likedPlant: { $in: plants },
        firstLiked: swipedPlant.user,
      });
      console.log(match);
      if (match.length > 0) {
        await Match.updateOne(
          { id: match._id, matched: false },
          {
            $set: { matched: true },
          }
        );
        const newChatRoom = new ChatRoom({
          user1: userId,
          user2: swipedPlant.user,
          plant1: match.likedPlant,
          plant2: swipedPlant,
        });
        await newChatRoom.save();
        res.send("Match object created");
        res.json(plants[0]);
      } else {
        const newMatch = new Match({
          firstLiked: userId,
          likedPlant: form.plantId,
        });
        await newMatch.save();
        res.send("Match object created");
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
