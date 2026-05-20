module.exports = (req, res, next) => {
  try {
    // cek apakah user ada dari auth middleware

    if (!req.user) {
      return res.status(401).json({
        message: "Unauthorized",
      });
    }

    // cek role

    if (req.user.role !== "admin") {
      return res.status(403).json({
        message: "Admin access only",
      });
    }

    next();
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
