var express = require('express'),
  router = express.Router();

//router.post('/', login);
router.get('/', logged);

function login(req, res) {
  var db = req.db;
  var collection = db.get('users');
  var user = req.body.user;
  collection.findOne(user, found);

  function found(err, doc) {
    var done = {};
    done.success = (doc && (err === null));
    if(done.success && req.body.session)
      req.session.mapIp(req.ip, doc._id);
    res.send(done);
  }
}

function logged(req, res) {
  var status = {};
  status.user = {}
  status.success = true//session.isMapedIp(req.ip);
  status.user.email = 'ivo' //result.email;
  status.user.password = 'ivo'//result.password;
  res.send(status);
  return
  var session = req.session;
  status.success = session.isMapedIp(req.ip);
  if(status.success) {
    status.user = {};
    var db = req.db
    var collection = db.get('users');
    collection.findById(session.find(req.ip), found);

    function found(err, result) {
      status.user.email = result.email;
      status.user.password = result.password;
      res.send(status);
    }
  }
}

module.exports = router;
