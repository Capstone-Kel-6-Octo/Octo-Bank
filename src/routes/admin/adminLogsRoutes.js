const router = require("express").Router();

const auth = require("../../middleware/auth");

const admin = require("../../middleware/admin");

const controller = require("../../controllers/admin/adminLogsController");

router.post("/logs", auth, admin, controller.createLog);

router.get("/logs", auth, admin, controller.getLogs);

router.get("/logs/:id", auth, admin, controller.getLogById);

module.exports = router;
