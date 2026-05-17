const router = require("express").Router();

const auth = require("../middleware/auth");

const controller = require("../controllers/consentController");

router.post("/", auth, controller.createConsent);

router.get("/:userId", auth, controller.getConsent);

router.put("/:userId", auth, controller.updateConsent);

module.exports = router;
