var express = require('express');
var server = require('http');
var path = require('path');
var htmlProvider = require('./html-provider');
var bodyParser = require('body-parser');
var users = require('./routes/user');

var clientDir = '../client';
var html = htmlProvider(clientDir);
var app = express();

app.use(express.static(path.join(__dirname, clientDir)));
app.use(bodyParser.json());
app.use('/users', users);
app.use(request);
app.use(error);

server = server.createServer(app);
server.listen(process.env.PORT || 3000);

function error (err, req, res, next) {
  res.send(html.provide('index'));
}

function request (req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
}
