var html = require('../html');
var router = (require('express')).Router();

router.get('/', function(req, res, next) {
  res.send(html.provide('index'));
});

module.exports = router;

