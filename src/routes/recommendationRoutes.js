const router = require("express").Router();

const auth = require("../middleware/auth");

const controller = require("../controllers/recommendationController");

router.post("/", auth, controller.createRecommendation);

router.get("/:userId", auth, controller.getRecommendations);

module.exports = router;
