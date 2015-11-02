var express = require('express'),
  router = express.Router();

router.get('/:email', exist);

router.post('/', register);

function exist(req, res) {
  var db = req.db,
    collection = db.get('users'),
    email = req.params.email,
    user = {};
  user.email = email;
  collection.findOne(user, found);

  function found(err, doc) {
    var exist = {};
    exist.exist =  (doc && (err === null));
    res.send(exist);
  }
}

function register(req, res) {
  var db = req.db,
    collection = db.get('users'),
    user = req.body.user;
  collection.insert(user, inserted);

  function inserted(err, doc) {
    var done = {};
    done.error = (err !== null);
    res.send(done);
  }
}

module.exports = router;
