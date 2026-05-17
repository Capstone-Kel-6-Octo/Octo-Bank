const express = require("express");
const cors = require("cors");
require("dotenv").config();

const pool = require("./config/db");

const app = express();

app.use(cors());
app.use(express.json());

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

app.listen(3000, () => console.log("Server running 🚀"));
