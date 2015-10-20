var express = require('express')
var router = express.Router();

router.get('/:email', get);

router.post('/', post);

function get (req, res) {
  var db = req.db;
  var collection = db.get('users');
  var email = req.params.email;
  var user = { email :  email };
  collection.findOne(user, find);

  function find (error, docs) {
    var exist = docs !== null;
    res.send({user : exist});
  }
}

function post (req, res) {
  var db = req.db;
  var collection = db.get('users');
  var user = req.body.user;
  collection.insert(user, insert);

  function insert (err, result) {
    var msg = {};
    msg.msg = err === null ? '' : err;
    res.send(msg);
  }
}

module.exports = router;
