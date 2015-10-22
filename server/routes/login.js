var express = require('express'),
  router = express.Router();

router.post('/', login);
router.get('/', logedin);

function login(req, res) {
  var collection = db.get('users'),
    user = req.body.user;
  collection.findOne(user, found);

  function found(err, result) {
    var done = {};
    if(result !== null)
      req.session.mapIp(req.ip, user);
    done.success = result !== null;
    res.send(done);
  }
}

function logedin(req, res) {
  var status = {};
  status.secret = req.session.findKey(req.ip);
  res.send(status);
}

module.exports = router;
