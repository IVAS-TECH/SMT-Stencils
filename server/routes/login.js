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
      req.session.mapIp(req.ip, user.email);
    done.success = result !== null;
    res.send(done);
  }
}

function logedin(req, res) {
  var status = {};
  status.success = req.session.isMapedIp(req.ip);
  if(status.success) 
    status.user = req.session.find(req.ip);
  res.send(status);
}

module.exports = router;
