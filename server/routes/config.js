var express = require('express');
var router = express.Router();

router.post('/', create);
//router.get('/', configs);
//router.put('/', update);

function create(req, res) {
  var db = req.db;
  var collection = db.get('configs');
  var config = req.body.config;
  //config.uid = req.find(req.ip);
  collection.insert(config, created);

  function created(err, doc) {
    var done = {};
    console.log(err, doc);
    done.success = (doc && (err === null));
    res.send(done);
  }
}

module.exports = router;
