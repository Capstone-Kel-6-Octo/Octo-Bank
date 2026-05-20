const router = require("express").Router();

const auth = require("../../middleware/auth");

const admin = require("../../middleware/admin");

const controller = require("../../controllers/admin/modelMonitoringController");

router.get("/models", auth, admin, controller.getModels);

router.get("/models/:id", auth, admin, controller.getModelById);

router.post("/models", auth, admin, controller.createModel);

router.put("/models/:id", auth, admin, controller.updateModel);

module.exports = router;
