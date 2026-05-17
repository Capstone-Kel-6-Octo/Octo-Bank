const router = require("express").Router();

const auth = require("../middleware/auth");
const controller = require("../controllers/homepageConfigController");

router.post("/", auth, controller.createConfig);

router.get("/:persona", auth, controller.getConfig);

router.put("/:id", auth, controller.updateConfig);

module.exports = router;
