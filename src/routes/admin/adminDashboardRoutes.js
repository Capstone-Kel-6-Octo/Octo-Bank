console.log("adminDashboardRoutes loaded");
const express = require("express");
const router = express.Router();

const {
  getDashboard
} = require("../../controllers/admin/adminDashboardController");

router.get("/dashboard", getDashboard);

module.exports = router;