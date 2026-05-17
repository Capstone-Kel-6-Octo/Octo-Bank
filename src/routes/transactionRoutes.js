const router = require("express").Router();

const auth = require("../middleware/auth");
const controller = require("../controllers/transactionController");

router.post("/", auth, controller.createTransaction);

router.get("/:userId", auth, controller.getUserTransactions);

router.get("/detail/:id", auth, controller.getTransactionById);

module.exports = router;
