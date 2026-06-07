const express = require("express");
const router = express.Router();

const {
  getFeatureAnalytics
} = require("../../controllers/admin/adminFeatureAnalyticsController");

router.get("/feature-analytics", getFeatureAnalytics);

module.exports = router;