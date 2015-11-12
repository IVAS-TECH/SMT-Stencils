var express = require('express');
var server = require('http');
var path = require('path');
var bodyParser = require('body-parser');
var monk = require('monk');
var register = require('./routes/register');
var login = require('./routes/login');
var logout = require('./routes/logout');
var profile = require('./routes/profile');
var files = require('./routes/files');
var session = require('./session');
var mapDir = require('./mapDir');
var multerConfig = require('./multerConfig');

var db = monk('0.0.0.0:27017/app');
var clientDir = '../client';
var clientDir = path.join(__dirname, clientDir);
var port = 3000;
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
app.use(serveMapedFile);

server = server.createServer(app);
server.listen(process.env.PORT || port);

function accessDB(req, res, next) {
    req.db = db;
    next();
}

function serveMapedFile(req, res, next) {
    if((req.method === 'GET') && fileMaper[req.url])
        res.sendFile(fileMaper[req.url]);
    else
        res.sendFile(fileMaper['/index']);
}
