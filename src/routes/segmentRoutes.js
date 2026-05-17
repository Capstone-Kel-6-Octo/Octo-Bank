const router = require("express").Router();

const auth = require("../middleware/auth");

const controller = require("../controllers/segmentController");

router.post("/", auth, controller.createSegment);

router.get("/:userId", auth, controller.getSegment);

router.put("/:userId", auth, controller.updateSegment);

module.exports = router;
