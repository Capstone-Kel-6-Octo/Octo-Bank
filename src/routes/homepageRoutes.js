const router = require('express').Router();
const c = require('../controllers/homepageController');
const auth = require('../middleware/auth');

router.get('/', auth, c.getHomepage);

module.exports = router;