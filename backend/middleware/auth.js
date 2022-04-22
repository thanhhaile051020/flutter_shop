const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const decodedToken = jwt.verify(token, "this_is_a_secret_key_by_@man_Sr1vastava");
    req.userData = {
      email: decodedToken.email,
      userId: decodedToken.userId,
      role: decodedToken.role,
    };
    next();
  } catch (error) {
    res.status(401).json({
      message: "You are not authenticated",
    });
  }
};
