const express = require("express");
const router = express.Router();

const {
  getUserAnalytics
} = require("../../controllers/admin/adminUserAnalyticsController");

router.get("/user-analytics", getUserAnalytics);

module.exports = router;