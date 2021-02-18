const jwt = require("jsonwebtoken");
const config = require("config");

module.exports = async function (req, res, next) {
  try {
    let token = req.cookies["x-auth-token"];
    if (token) {
      console.log("inne i token");
      const decode = jwt.verify(token, config.get("myprivatekey"));
      req.user = decode;
      req.token = token;
      next();
    } else {
      // cookie not found redirect to login
      //return res.redirect("/login");
      console.log("cookie not found");
    }
  } catch (e) {
    console.error(e.message);
    res.send("Please Login! ");
  }
};
