const router = require("express").Router();

const featureController = require("../controllers/featureController");
const auth = require("../middleware/auth");

router.get("/", auth, featureController.getAllFeatures);

router.post("/", auth, featureController.createFeature);

module.exports = router;
