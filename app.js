var express = require('express');
var server = require('http');
var html = require('./html-provider')('./app/');
var app = express();
app.use(express.static(require('path').join(__dirname, 'app')));
app.use(require('body-parser').json());
app.use('/', function (req, res, next) { res.send(html.provide('index')); });
app.use('/users', require('./routes/user'));
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});
app.use(function(err, req, res, next) { res.send(html.provide('error')); });
server = server.createServer(app);
server.listen(process.env.PORT || 3000);
