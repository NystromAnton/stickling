const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

const UserSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    minlength: 3,
    maxlength: 255,
  },
  location: {
    type: { type: String },
    coordinates: [Number]
 },
});

UserSchema.methods.comparePassword = async function (user, password) {
  const match = await bcrypt.compare(password, user.password);

  if (match) {
    return true;
    //login
  } else {
    return false;
  }

  //...
};
//function to validate user
function validateUser(user) {
  const schema = {
    //name: Joi.string().min(3).max(50).required(),
    email: Joi.string().min(5).max(255).required().email(),
    password: Joi.string().min(3).max(255).required(),
  };

  return Joi.validate(user, schema);
}

async function checkUser(email, psw) {
  const user = await Users.findOne({ email });
  console.log(user);
  const match = await bcrypt.compare(psw, user.passsword);
  if (!user || !match) {
    throw new Error("Login Failed, please try again");
  }
  return user;
}

exports.validate = validateUser;
module.exports = User = mongoose.model("users", UserSchema);
