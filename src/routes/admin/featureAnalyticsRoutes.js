const router = require("express").Router();

const auth = require("../../middleware/auth");

const admin = require("../../middleware/admin");

const controller = require("../../controllers/admin/featureAnalyticsController");

router.get("/features", auth, admin, controller.getFeatures);

router.get("/features/detail", auth, admin, controller.getFeatureDetails);

router.get("/features/trend", auth, admin, controller.getFeatureTrend);

router.get("/top-features", auth, admin, controller.getTopFeatures);

module.exports = router;
