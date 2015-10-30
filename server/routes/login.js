var express = require('express'),
  router = express.Router();

router.post('/', login);
router.get('/', loggedin);

function login(req, res) {
  var collection = db.get('users'),
    user = req.body.user;
  collection.findOne(user, found);

  function found(err, result) {
    var done = {};
    done.success = result !== null;
    if(done.success && req.body.session)
      req.session.mapIp(req.ip, result._id);
    res.send(done);
  }
}

function loggedin(req, res) {
  var status = {};
  status.success = req.session.isMapedIp(req.ip);
  if(status.success) {
    status.user = {};
    var collection = db.get('users');
    collection.findById(req.session.find(req.ip), found);

    function found(err, result) {
      status.user.email = result.email;
      status.user.password = result.password;
      res.send(status);
    }
  }
}

module.exports = router;
