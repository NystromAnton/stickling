var express = require("express");
var router = express.Router();
const bcrypt = require("bcrypt");
const User = require("../models/userModel");

/* GET users listing. */
router.get("/:name", async function (req, res, next) {
  var name = req.params.name;
  console.log(name);
  var user = await User.find({ name: name });
  res.send(user);
});

router.get("/by-id/:id", async function (req, res, next) {
  var id = req.params.id;
  var user = await User.findById(id);
  res.send(user);
});

router.post("/update-location", async function (req, res, next) {
  var form = req.body;

  try {
    var user = await User.findOneAndUpdate(
      {
        _id: form.id,
      },
      {
        $set: {
          "location.coordinates": form.coordinates,
        },
      }
    ).exec();
    res.json(user);
  } catch (err) {
    console.error("Failure " + err.message);
    res.status(500).json({ message: "Server error" + err.message });
  }
});

router.post("/signup", async function (req, res, next) {
  var form = req.body;
  try {
    let user = await User.findOne({ email: req.body.email });
    if (user) return res.status(400).send("User already registered.");

    const newUser = new User({
      name: form.name,
      email: form.email,
      password: form.password,
      location: form.location,
    });
    newUser.password = await bcrypt.hash(newUser.password, 10);

    await newUser.save();
    res.send(newUser);
  } catch (err) {
    console.error("Issue with signup " + err.message);
    res.status(500).json({ message: "Server error" });
  }
});
router.post("/login", async function (req, res, next) {
  try {
    const user = await User.findOne({ email: req.body.email });

    match = await user.comparePassword(user, req.body.password);
    if (match) {
      console.log("här inne");

      let options = {
        path: "/",
        sameSite: true,
        maxAge: 1000 * 60 * 60 * 24, // would expire after 24 hours
        httpOnly: true, // The cookie only accessible by the web server
      };

      res.send(user._id);
    } else {
      res.send("Email and password doesn't match");
    }
  } catch (e) {
    res.send("login failed");
  }
});

module.exports = router;
