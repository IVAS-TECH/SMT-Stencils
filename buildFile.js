var child_process = require('child_process');
var spawn = child_process.spawnSync;
var npm = spawn('npm', ['install']);
var bower = spawn('bower', ['install']);
var fs = require('fs-extra');
var path = require('path')
var walk = require('walk')
var stylus = require('stylus')
var nib = require('nib')
var gerbersToSvgLayers = require('./server/gerbersToSvgLayers')
var dir = __dirname;
var walker = walk.walk(path.join(dir, 'client/resources/samples'))
var files = []
var styl = path.join(dir, 'client/styles/styl-style.styl')
var dependenciesDir = dir + '/client/dependencies';
var transpiler = '/node_modules/babel-core/browser.js';
var css = ['/bower_components/angular-material/angular-material.css'];
var dependecies = [
    '/bower_components/jquery/dist/jquery.js',
    '/bower_components/lodash/lodash.js',
    '/bower_components/angular/angular.js',
    '/bower_components/angular-ui-router/release/angular-ui-router.js',
    '/bower_components/ui-router-extras/release/ct-ui-router-extras.js',
    '/bower_components/angular-ui-router.stateHelper/statehelper.js',
    '/bower_components/angular-aria/angular-aria.js',
    '/bower_components/angular-animate/angular-animate.js',
    '/bower_components/angular-messages/angular-messages.js',
    '/bower_components/angular-material/angular-material.js',
    '/bower_components/restangular/dist/restangular.js',
    '/node_modules/es6-module-loader/dist/es6-module-loader-dev.js',
    '/bower_components/ng-file-upload/ng-file-upload.min.js'
];
styleIt(fs.readFileSync(styl, 'utf8'))
if(process.argv[2] === 'stylus')
  return
fs.emptyDirSync(dependenciesDir);
fs.copySync(dir + css[0], dependenciesDir + '/angular-material.css');
fs.copySync(dir + transpiler, dependenciesDir + '/browser.js');
concatFiles(dependecies, dependenciesDir + '/dependencies.js');
fs.removeSync(dir + '/bower_components');
walker.on('file', add)
walker.on('end', svg)
if(process.argv[2] === 'start')
  server = spawn(process.argv[0], [dir + '/server/app.js']);

function styleIt(data) {
  stylus(data)
    .use(nib())
    .render(compile)

    function compile(cssErr, css) {
      var style = path.join(dir, 'client/styles/style.css')
      fs.writeFileSync(style, css, 'utf8')
    }
}

function concatFiles(files, out) {
    var result = '';
    for (var i = 0; i < files.length; ++i) {
        var file = dir + files[i];
        result += fs.readFileSync(file, 'utf8');
    }
    fs.createFileSync(out);
    fs.writeFileSync(out, result, 'utf8');
}

function add(root, file, next) {
  var pathTo = path.join(root, file.name)
  var item = {}
  item.content = fs.readFileSync(pathTo, 'utf-8')
  item.name = pathTo
  files.push(item)
  next()
}

function svg() {
  var svgs = (gerbersToSvgLayers(files))
  var top = path.join(dir, 'client/resources/top.svg')
  fs.writeFileSync(top, svgs.top, 'utf8');
}
