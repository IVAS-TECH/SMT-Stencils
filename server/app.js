var express = require('express'),
  server = require('http'),
  path = require('path'),
  bodyParser = require('body-parser'),
  monk = require('monk'),
  register = require('./routes/register'),
  login = require('./routes/login'),
  logout = require('./routes/logout'),
  session = require('./session'),
  mapDir = require('./mapDir');

  db = monk('0.0.0.0:27017/app'),
  clientDir = '../client',
  clientDir = path.join(__dirname, clientDir),
  port = 3000,
  app = express(),
  fileMaper = mapDir(clientDir);

app.use(bodyParser.json());
app.use(access);
app.use(session.use());
app.use('/register', register);
app.use('/login', login);
app.use('/logout', logout);
app.use(serveMapedFile);
app.use(request);
app.use(error);

server = server.createServer(app);
server.listen(process.env.PORT || port);

function access(req, res, next) {
  req.db = db;
  next();
}

function error(err, req, res, next) {
  res.sendFile(fileMaper['/error']);
}

function request(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
}

function serveMapedFile(req, res, next) {
  if(req.url === '/') {
    res.sendFile(fileMaper['/index']);
    return;
  }

  if((req.method  === 'GET') && fileMaper[req.url])
    res.sendFile(fileMaper[req.url]);
  else
    next();
}
