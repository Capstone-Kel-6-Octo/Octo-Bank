const router = require("express").Router();

const auth = require("../../middleware/auth");

const admin = require("../../middleware/admin");

const controller = require("../../controllers/admin/abTestingController");

router.get("/ab-testing", auth, admin, controller.getGroups);

router.get("/analytics/ctr", auth, admin, controller.getCTR);

router.get("/analytics/ctr/group", auth, admin, controller.getCTRByGroup);

module.exports = router;
