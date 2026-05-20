const router = require("express").Router();

const auth = require("../../middleware/auth");

const admin = require("../../middleware/admin");

const controller = require("../../controllers/admin/segmentAnalyticsController");

router.get("/segments", auth, admin, controller.getSegments);

router.get("/clusters", auth, admin, controller.getClusters);

router.get("/segments/trend", auth, admin, controller.getSegmentTrend);

router.get("/clusters/trend", auth, admin, controller.getClusterTrend);

module.exports = router;
