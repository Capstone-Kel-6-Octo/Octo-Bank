const express = require("express");
const cors = require("cors");
require("dotenv").config();

const pool = require("./config/db");

const app = express();

app.use(cors());
app.use(express.json());

// user
app.use("/auth", require("./routes/authRoutes"));
app.use("/interactions", require("./routes/interactionRoutes"));
app.use("/homepage", require("./routes/homepageRoutes"));
app.use("/users", require("./routes/userRoutes"));
app.use("/features", require("./routes/featureRoutes"));
app.use("/transactions", require("./routes/transactionRoutes"));
app.use("/segments", require("./routes/segmentRoutes"));
app.use("/homepage-config", require("./routes/homepageConfigRoutes"));
app.use("/consents", require("./routes/consentRoutes"));
app.use("/recommendations", require("./routes/recommendationRoutes"));
app.use("/ml", require("./routes/mlRoutes"));

// admin
app.use("/admin/analytics", require("./routes/admin/featureAnalyticsRoutes"));
app.use("/admin/analytics", require("./routes/admin/segmentAnalyticsRoutes"));
app.use("/admin", require("./routes/admin/consentAnalyticsRoutes"));
app.use("/admin", require("./routes/admin/abTestingRoutes"));
app.use("/admin", require("./routes/admin/adminLogsRoutes"));
app.use("/admin", require("./routes/admin/modelMonitoringRoutes"));
app.use("/admin", require("./routes/admin/adminDashboardRoutes"));
app.use("/admin", require("./routes/admin/adminUserAnalyticsRoutes"));
app.use("/admin", require("./routes/admin/adminPersonalizationRoutes"));
app.use("/admin", require("./routes/admin/adminFeatureAnalyticsRoutes"));

app.listen(3000, () => console.log("Server running 🚀"));

app.listen(3000, () => {
  console.log(`Server running on port ${PORT}`);
});
