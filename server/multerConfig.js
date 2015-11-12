var multer = require('multer');

function config(dir) {
  var configStorage = {};
  configStorage.destination = dir + '/files';
  configStorage.filename = filename;
  var storage = multer.diskStorage(configStorage);
  var configMulter = {};
  configMulter.storage = storage;
  configMulter.limits = {};
  configMulter.limits.fileSize = 40000000000;
  configMulter.files = 6;
  var multerConfigObj = multer(configMulter);
  return multerConfigObj;

  function filename(req, file, cb) {
    var uid = req.session.find(req.ip);
    uid = 'a';
    var name = uid + '_' + file.originalname;
    cb(null, name);
  }
}

module.exports = config;
