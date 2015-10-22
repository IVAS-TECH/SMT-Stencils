var express = require('express'),
  server = require('http'),
  path = require('path'),
  bodyParser = require('body-parser'),
  monk = require('monk'),
  register = require('./routes/register'),
  walk = require('walk'),

  fileMaper = {},
  db = monk('0.0.0.0:27017/app'),
  clientDir = '../client',
  clientDir = path.join(__dirname, clientDir),
  walker = walk.walk(clientDir),
  port = 3000,
  app = express();

walker.on('file', addToFileMaper);

app.use(dbAccess);
app.use(bodyParser.json());
app.use('/register', register);
app.use('/login', login);
app.use(serveMapedFile);
app.use(request);
app.use(error);

server = server.createServer(app);
server.listen(process.env.PORT || port);

function dbAccess(req,res,next) {
  req.db = db;
  next();
}

function error(err, req, res, next) {
  var error = 'error.html';
  res.sendFile(path.join(clientDir, error));
}

function request(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
}

function addToFileMaper(root, fileStats, next) {
  var name = fileStats.name,
    file = name.split('.'),
    resource = path.join(root, name),
    mapped = '/' + file[0];
  fileMaper[mapped] = resource;
  next();
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

function login(req, res) {
  var collection = db.get('users'),
    user = req.body.user;
  collection.findOne(user, found);

  function found(err, result) {
    var done = {};
    done.success = result !== null;
    res.send(done);
  }
}
