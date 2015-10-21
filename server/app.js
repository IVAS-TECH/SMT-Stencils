var express = require('express');
var server = require('http');
var path = require('path');
var bodyParser = require('body-parser');
var monk = require('monk');
var register = require('./routes/register');
var walk = require('walk');

var fileMaper = {};
var db = monk('0.0.0.0:27017/app');
var clientDir = '../client';
var clientDir = path.join(__dirname, clientDir);
var walker = walk.walk(clientDir);
var port = 3000;
var app = express();

walker.on('file', addToFileMaper);

app.use(dbAccess);
app.use(bodyParser.json());
app.use('/register', register);
app.use(serveMapedFile);
app.use(request);
app.use(error);

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

function addToFileMaper (root, fileStats, next) {
  var name = fileStats.name;
  var file = name.split('.');
  var resource = path.join(root, name);
  var mapped = '/' + file[0];
  fileMaper[mapped] = resource;
  next();
}

function serveMapedFile (req, res, next) {
  if(req.url === '/') {
    res.sendFile(fileMaper['/index']);
    return;
  }
  
  if((req.method  === 'GET') && fileMaper[req.url])
    res.sendFile(fileMaper[req.url]);
  else
    next();
}
