const express = require("express");
const router = express.Router();

const {
  getPersonalizationAnalytics
} = require("../../controllers/admin/adminPersonalizationController");

router.get("/personalization", getPersonalizationAnalytics);

module.exports = router;