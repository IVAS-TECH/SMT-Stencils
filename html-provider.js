var htmlProvider = function (views) {
  this.views = views;
  this.provide = function (view) {
    return require('fs').readFileSync(this.views + view + '.html', 'utf8');
  };
};

module.exports = function (views) {
  return new htmlProvider(views);
};
