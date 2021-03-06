var express = require("express");
var router = express.Router();
const User = require("../models/userModel");
const Plant = require("../models/plantModel");
const Match = require("../models/matchModel");
const MySwipeHistory = require("../models/mySwipeHistory");
const ChatRoom = require("../models/chatRoomModel");

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
        const newSwipeHistory = new MySwipeHistory({
          myUserID: userId,
          userID: swipedPlant.user,
          plantID: swipedPlant._id,
          title: swipedPlant.title,
          desc: swipedPlant.desc,
          type: swipedPlant.type,
          matched: true,
        });
        await newSwipeHistory.save();
        var chatExist = await ChatRoom.find({
          $or: [
            { $and: [{ user1ID: userId }, { user2ID: swipedPlant.user }] },
            { $and: [{ user1ID: swipedPlant.user }, { user2ID: userId }] },
          ],
        });
        console.log("CHATEXIST:" + chatExist);
        if (chatExist.length < 1) {
          const newChatRoom = new ChatRoom({
            user1ID: userId,
            user2ID: swipedPlant.user,
            plant1ID: match[0].likedPlant,
            plant2ID: swipedPlant._id,
          });
          await newChatRoom.save();
          res.send("Match");
        } else {
          res.send("Chat already exist");
        }
      } else {
        const newMatch = new Match({
          firstLiked: userId,
          likedPlant: form.plantId,
        });
        await newMatch.save();
        const newSwipeHistory = new MySwipeHistory({
          myUserID: userId,
          userID: swipedPlant.user,
          plantID: swipedPlant._id,
          title: swipedPlant.title,
          desc: swipedPlant.desc,
          type: swipedPlant.type,
        });
        await newSwipeHistory.save();
        res.send("Swipe registered");
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
