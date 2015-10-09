var router = require('express').Router();

router.get('/', function(req, res, next) {
  res.send({mes : 'ivo'});
});

module.exports = router;

