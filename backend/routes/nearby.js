var express = require("express");
var router = express.Router();
const User = require("../models/userModel");
const Plant = require("../models/plantModel");
const Match = require("../models/matchModel");
const Preference = require("../models/preferenceModel");
const mongoose = require("mongoose");

router.get("/:id", async function (req, res, next) {
  var coord = req.query.q;
  var splitCoord = coord.split(",");
  var long = parseFloat(splitCoord[0]);
  var lat = parseFloat(splitCoord[1]);
  console.log(lat);
  console.log(long);

  var id = req.params.id;
  console.log(id);
  var preference = await Preference.find({ user: id });
  console.log(preference);
  var types = preference[0].types;
  var distance = preference[0].distance;
  User.aggregate(
    [
      {
        $geoNear: {
          near: {
            type: "Point",
            coordinates: [long, lat],
          },
          distanceField: "dist.calculated",
          maxDistance: Number(distance),
          spherical: true,
        },
      },
      {
        $lookup: {
          from: Plant.collection.name,
          localField: "_id",
          foreignField: "user",
          as: "plants",
        },
      },
      { $unwind: "$plants" },
      {
        $match: {
          "plants.type": { $in: types },
          "plants.user": { $ne: mongoose.Types.ObjectId(id) },
        },
      },
      {
        $project: {
          _id: 1,
          userName: 1,
          email: 1,
          plantID: "$plants._id",
          pic: "$plants.pic",
          title: "$plants.title",
          desc: "$plants.desc",
          type: "$plants.type",
          distance: { $divide: ["$dist.calculated", 1000] },
        },
      },
    ],
    (err, data) => {
      if (err) {
        next(err);
        return;
      }
      /*
      var arr = [];
      for (i = 0; i < data.length; i++) {
        arr.push(data[i].plants);
      }
      console.log(arr);
      */
      res.json(data);
    }
  );
});

module.exports = router;
