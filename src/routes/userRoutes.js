const router = require("express").Router();

const userController = require("../controllers/userController");
const auth = require("../middleware/auth");

// GET PROFILE
router.get("/:id", auth, userController.getUserById);

// UPDATE PROFILE
router.put("/:id", auth, userController.updateUser);

module.exports = router;
