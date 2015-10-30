var express = require('express'),
  router = express.Router();

router.post('/', profile);

function profile(req, res) {
  var collection = db.get('users'),
    find = '',
    change = {},
    set = {};
  find = req.session.find(req.ip);
  change[req.body.type] = req.body.value;
  set.$set = change;
  collection.updateById(find, set, found);

  function found(err, result) {
    var done = {};
    done.success = ((result !== null) && (err === null));
    res.send(done);
  }
}

module.exports = router;
