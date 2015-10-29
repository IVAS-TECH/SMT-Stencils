var express = require('express'),
  router = express.Router();

router.post('/', profile);

function profile(req, res) {
  var collection = db.get('users'),
    find = '',
    change = {},
    set = {};
  find = req.session.find(req.ip);
  console.log("find", find);
  change[req.body.type] = req.body.value;
  set.$set = change;
  console.log("set", set);
  collection.updateById(find, set, found);
  collection.find({}, function(e, d) {console.log(d);});

  function found(err, result) {
    console.log(err, result);
    var done = {};
    done.success = result !== null;
    res.send(done);
  }
}

module.exports = router;
