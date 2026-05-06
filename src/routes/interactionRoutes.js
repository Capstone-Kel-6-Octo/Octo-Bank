const router = require('express').Router();
const c = require('../controllers/interactionController');
const auth = require('../middleware/auth');

router.post('/', auth, c.create);
router.get('/:userId', auth, c.getByUser);

module.exports = router;