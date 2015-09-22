var path = require('path');
var bodyParser = require('body-parser');
var express = require('express');
var http = require('http');
var routes = require('./routes/index');
var users = require('./routes/user');
var provider = require('./html-provider');
var html = provider('./app/views/');
var app = express();
app.use(express.static(path.join(__dirname, 'app')));
app.use(bodyParser.json());
app.use('/users', users);
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});
app.use(function(err, req, res, next) {
  res.send(html.provide('error'));
});
var server = http.createServer(app);
server.listen(process.env.PORT || 3000);
