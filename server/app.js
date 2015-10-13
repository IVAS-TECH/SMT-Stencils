var express = require('express');
var server = require('http');
var path = require('path');
var htmlProvider = require('./html-provider');
var bodyParser = require('body-parser');
var monk = require('monk');
var register = require('./routes/register');

var db = monk('0.0.0.0:27017/app');
var clientDir = '../client';
var html = htmlProvider(clientDir);
var app = express();

app.use(dbAccess);
app.use(express.static(path.join(__dirname, clientDir)));
app.use(bodyParser.json());
app.use('/register', register);
app.use(request);
app.use(error);

server = server.createServer(app);
server.listen(process.env.PORT || 3000);

function dbAccess (req,res,next) {
  req.db = db;
  next();
}

function error (err, req, res, next) {
  res.send(html.provide('index'));
}

function request (req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
}
