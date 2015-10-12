var express = require('express')
var router = express.Router();

router.get('/:email', get);

function get (req, res, next) {
  var db = req.db;
  var collection = db.get('users');
  var email = req.params.email;
  var user = { email :  email };
  collection.findOne(user, find);

  function find (error, docs) {
    var exist = !(docs === null);
    res.send({user : exist});
  }
}

module.exports = router;
