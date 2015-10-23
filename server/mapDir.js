var walk = require('walk'),
  path = require('path');

function mapDir(dir) {
  var walker = walk.walk(dir),
    fileMaper = {};
  walker.on('file', addToFileMaper);

  function addToFileMaper(root, fileStats, next) {
    var name = fileStats.name,
      file = name.split('.'),
      resource = path.join(root, name),
      mapped = '/' + file[0];
    fileMaper[mapped] = resource;
    next();
  }

  return fileMaper;
}

module.exports = mapDir;
