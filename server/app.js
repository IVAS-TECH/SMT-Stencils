var express = require('express');
var server = require('http');
var path = require('path');
var bodyParser = require('body-parser');
var monk = require('monk');
var register = require('./routes/register');
var login = require('./routes/login');
var logout = require('./routes/logout');
var profile = require('./routes/profile');
var session = require('./session');
var mapDir = require('./mapDir');

var db = monk('0.0.0.0:27017/app');
var clientDir = '../client';
var clientDir = path.join(__dirname, clientDir);
var port = 3000;
var app = express();
var fileMaper = mapDir(clientDir);

app.use(bodyParser.json());
app.use(access);
app.use(session.use());
app.use('/register', register);
app.use('/login', login);
app.use('/logout', logout);
app.use('/profile', profile);
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
    if (req.url === '/') {
        res.sendFile(fileMaper['/index']);
        return;
    }

    if ((req.method === 'GET') && fileMaper[req.url])
        res.sendFile(fileMaper[req.url]);
    else
        next();
}
