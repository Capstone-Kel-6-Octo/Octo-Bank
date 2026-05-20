const router = require("express").Router();

const auth = require("../../middleware/auth");

const admin = require("../../middleware/admin");

const controller = require("../../controllers/admin/consentAnalyticsController");

router.get("/consents", auth, admin, controller.getConsents);

router.get("/consents/summary", auth, admin, controller.getConsentSummary);

router.get("/consents/trend", auth, admin, controller.getConsentTrend);

module.exports = router;
