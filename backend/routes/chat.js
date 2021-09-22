var express = require("express");
var router = express.Router();
var mongoose = require("mongoose");
const { body, validationResult } = require("express-validator");

const chat = require("../models/chatModel");
const User = require("../models/userModel");

/* GET users listing. */
/*
router.get("/user1-viewed", async (req, res) => {
  var id = req.user._id;
  var hasViewed = await chat.countDocuments({
    user1Viewed: false,
    user1ID: id,
  });
  //console.log(hasViewed);
  // Send back number of notifications
  res.json(hasViewed);
});
*/
/*
router.get("/client-viewed", async (req, res) => {
  var id = req.user._id;
  var hasViewed = await chat.countDocuments({
    userID: id,
    clientViewed: false,
  });
  // Send back number of notifications
  res.json(hasViewed);
});
*/

/* GET SINGLE CHAT BY ID */
router.get("/:id", function (req, res, next) {
  let id = req.params.id;
  chat.find({ chatRoom: id }, function (err, post) {
    if (err) return next(err);
    res.json(post);
  });
});

/* SAVE CHAT */
router.post("/", async function (req, res, next) {
  chat.create(req.body, function (err, post) {
    if (err) return next(err);
    res.json(post);
  });
});

/*
router.post(
  "/add-view",
  [
    body("chatRoom", "Invalid input").trim().escape().isLength({
      min: 1,
    }),
  ],
  
  async (req, res, next) => {
    var userID = req.user._id;
    var chatRoom = req.body.chatRoom;
    var userType = req.body.userType;
    var hasViewed;
    var chats;
    if (userType == "user1") {
      chats = await chat
        .updateMany(
          {
            chatRoom: chatRoom,
          },

          {
            $set: {
              user1Viewed: true,
            },
          }
        )
        .exec();
      hasViewed = await chat.countDocuments({
        user1Viewed: false,
        user1ID: userID,
      });
    } else {
      chats = await chat
        .updateMany(
          {
            chatRoom: chatRoom,
          },

          {
            $set: {
              clientViewed: true,
            },
          }
        )
        .exec();
      hasViewed = await chat.countDocuments({
        clientViewed: false,
        userID: userID,
      });
    }

    res.json(hasViewed);
  }
);
*/

/* UPDATE CHAT */
router.put("/:id", function (req, res, next) {
  chat.findByIdAndUpdate(req.params.id, req.body, function (err, post) {
    if (err) return next(err);
    res.json(post);
  });
});

/* DELETE CHAT */
router.delete("/:id", function (req, res, next) {
  chat.findByIdAndRemove(req.params.id, req.body, function (err, post) {
    if (err) return next(err);
    res.json(post);
  });
});

module.exports = router;
