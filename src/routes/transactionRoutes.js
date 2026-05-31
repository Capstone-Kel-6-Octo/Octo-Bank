const router = require("express").Router();

const auth = require("../middleware/auth");
const controller = require("../controllers/transactionController");

router.post("/", auth, controller.createTransaction);

router.post("/transfer", auth, controller.transfer);

router.get("/detail/:id", auth, controller.getTransactionById);

router.get("/:userId", auth, controller.getUserTransactions);

module.exports = router;
