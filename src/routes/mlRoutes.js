const router = require("express").Router();

const auth = require("../middleware/auth");

const controller = require("../controllers/mlController");

router.post("/sync/:userId", auth, controller.syncUserML);

module.exports = router;
