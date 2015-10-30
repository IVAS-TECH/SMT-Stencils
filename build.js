var child_process = require('child_process');
var spawn = child_process.spawnSync;
//var npm = spawn('npm', ['install']);
//var bower = spawn('bower', ['install']);
var fs = require('fs-extra');
var dir = __dirname;
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
    '/node_modules/es6-module-loader/dist/es6-module-loader-dev.js'
];

fs.emptyDirSync(dependenciesDir);
fs.copy(dir + css[0], dependenciesDir + '/angular-material.css', callback);
fs.copy(dir + transpiler, dependenciesDir + '/browser.js', callback);
concatFiles(dependecies, dependenciesDir + '/dependencies.js');
//fs.removeSync(dir + '/bower_components');

function callback(err) {
    if (err)
        throw err;
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
