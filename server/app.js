var express = require('express');
var server = require('http');
var path = require('path');
var bodyParser = require('body-parser');
var monk = require('monk');
var register = require('./routes/register');
var walk = require('walk');

var db = monk('0.0.0.0:27017/app');
var clientDir = '../client';
var clientDir = path.join(__dirname, clientDir);
var walker = walk.walk(clientDir);
var port = 3000;
var app = express();

app.use(test);
app.use(dbAccess);
app.use(express.static(clientDir));
app.use(bodyParser.json());
app.use('/register', register);
app.use(request);
app.use(error);

walker.on('file', addToPathJS);

server = server.createServer(app);
server.listen(process.env.PORT || port);

function dbAccess (req,res,next) {
  req.db = db;
  next();
}

function error (err, req, res, next) {
  var error = 'error.html';
  res.sendFile(path.join(clientDir, error));
}

function request (req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
}

function addToPathJS (root, fileStats, next) {
  var dir = root.replace(clientDir, '');
  console.log(dir, fileStats.name);
  next();
}

function test (req, res, next) {
  console.log(req);
    next();

}
