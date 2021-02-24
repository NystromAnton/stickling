var express = require("express");
var router = express.Router();
const User = require("../models/userModel");
const Plant = require("../models/plantModel");
const Match = require("../models/matchModel");

router.get("/", async function(req, res, next){
    var coord = req.query.q;
    var splitCoord = coord.split(",");
    var long = parseFloat(splitCoord[0]);
    var lat = parseFloat(splitCoord[1]);
    console.log(lat);
    console.log(long);

    User.aggregate([
        {
            $geoNear: {
                near: {
                    type: "Point",
                    coordinates: [long, lat],
                },
                distanceField: "dist.calculated",
                maxDistance: 2,
                spherical: true,
                },
            },
        
    ],
    (err, data)=> {
        if(err) {
            next(err);
            return;
        }
        console.log(data);
        res.json(data);
    })
});

module.exports = router;
