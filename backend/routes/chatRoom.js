var express = require("express");
var router = express.Router();
var mongoose = require("mongoose");
var chatRoom = require("../models/chatRoomModel.js");
var User = require("../models/userModel");
var Chat = require("../models/chatModel");

// GET ALL USERS ROOMS BY userID
router.get("/user/:id", function (req, res, next) {
  chatRoom.aggregate(
    [
      {
        $match: {
          $or: [{ user1ID: req.params.id }, { user2ID: req.params.id }],
        },
      },
      {
        $lookup: {
          from: User.collection.name,
          localField: "user2ID",
          foreignField: "_id",
          as: "user2",
        },
      },
      { $unwind: "$user2" },
      {
        $lookup: {
          from: User.collection.name,
          localField: "user1ID",
          foreignField: "_id",
          as: "user1",
        },
      },
      { $unwind: "$user1" },
      {
        $lookup: {
          from: Chat.collection.name,
          localField: "_id",
          foreignField: "chatRoom",
          as: "chats",
        },
      },
      {
        $project: {
          _id: 1,
          user1: 1,
          user2: 1,
          recent_chat: { $arrayElemAt: ["$chats", -1] },
        },
      },
      { $sort: { recent_chat: -1 } },
    ],
    (err, data) => {
      if (err) {
        next(err);
        return;
      }
      //console.log(data)
      res.json(data);
    }
  );
});

// GET SINGLE ROOM BY ID
router.get("/:id", function (req, res, next) {
  chatRoom.findById(req.params.id, function (err, post) {
    if (err) return next(err);
    res.json(post);
  });
});

/* GET ROOM by listingID and menderID
router.get('/specificRoom', auth, function(req, res, next) {
    chatRoom.find({listingID: req.params.listingID,
                   menderID: req.params.menderID},
                   function (err, products) {
      if (err) return next(err);
      res.json(products);
    });
  });

router.get('/mender', auth, function(req, res, next) {
  chatRoom.find({menderID: req.user._id}, function (err, products) {
    if (err) return next(err);
    res.json(products);
  });
});


router.get('/user', auth, function(req, res, next) {
    console.log(req)
    console.log("here)")
    chatRoom.find({userID: req.user._id}, function (err, products) {
      if (err) return next(err);
      res.json(products);
    });
  });
*/

/* SAVE ROOM */
router.post("/", function (req, res, next) {
  chatRoom.create(req.body, function (err, post) {
    if (err) return next(err);
    res.json(post);
    /*Chat.create(
      {
        user1: mongoose.Types.ObjectId(post.user1),
        user2: mongoose.Types.ObjectId(post.user2),
        plant1: mongoose.Types.ObjectId(post.match),
        plant2: mongoose.Types.ObjectId(post.match),
      },
      function (err, post) {
        if (err) return next(err);
      }
    );*/
  });
});

/* UPDATE ROOM */
router.put("/:id", function (req, res, next) {
  chatRoom.findByIdAndUpdate(req.params.id, req.body, function (err, post) {
    if (err) return next(err);
    res.json(post);
  });
});

/* DELETE ROOM */
router.delete("/:id", function (req, res, next) {
  chatRoom.findByIdAndRemove(req.params.id, req.body, function (err, post) {
    if (err) return next(err);
    res.json(post);
  });
});

module.exports = router;
