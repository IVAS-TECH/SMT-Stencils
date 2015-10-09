var fs = require('fs');

function  htmlProvider (views) {
  this.views = views;
  this.provide = provide;

  function provide (view) {
    var file = __dirname + '/' + this.views + '/' + view + '.html';
    return fs.readFileSync(file, 'utf8');
  }

}

module.exports = function (views) {
  return new htmlProvider(views);
};
