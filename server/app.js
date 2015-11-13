var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var monk = require('monk');
var register = require('./routes/register');
var login = require('./routes/login');
var logout = require('./routes/logout');
var profile = require('./routes/profile');
var files = require('./routes/files');
var config = require('./routes/config');
var session = require('./session');
var mapDir = require('./mapDir');
var multerConfig = require('./multerConfig');

var db = monk('0.0.0.0:27017/app');
var clientDir = path.join(__dirname, '../client');
var port = process.env.PORT || 3000;
var app = express();
var fileMaper = mapDir(clientDir);
var multerConfigObj = multerConfig(clientDir);
var multerMiddleware = multerConfigObj.any();

app.use(bodyParser.json());
app.use(accessDB);
app.use(session.use(db.get('session')));
app.post('/files', multerMiddleware, files);
app.use('/register', register);
app.use('/login', login);
app.get('/logout', logout);
app.post('/profile', profile);
app.use('/config', config);
app.use(serveMapedFile);
app.listen(port);

function accessDB(req, res, next) {
    req.db = db;
    next();
}

function serveMapedFile(req, res, next) {
    if(req.method === 'GET') {
      if(fileMaper[req.url]) {
        res.sendFile(fileMaper[req.url]);
        return;
      }
      else {
        var index = ['/', '/about', '/tech', '/order', '/contact'];
        var found = index.indexOf(req.url);
        if(found > -1) {
          res.sendFile(fileMaper['/index']);
          return;
        }
      }
    }
    res.sendFile(fileMaper['/error']);
}
