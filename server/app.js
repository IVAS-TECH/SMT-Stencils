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
var multer = require('multer');
var fs = require('fs');
var gerberParser = require('gerber-parser');

var db = monk('0.0.0.0:27017/app');
var clientDir = '../client';
var clientDir = path.join(__dirname, clientDir);
var port = 3000;
var app = express();
var fileMaper = mapDir(clientDir);
var configStorage = {};
configStorage.destination = clientDir + '/files';
configStorage.filename = filename;
var storage = multer.diskStorage(configStorage);
var configMulter = {};
configMulter.storage = storage;
configMulter.limits = {};
configMulter.limits.fileSize = 40000000000;
configMulter.files = 6;
var multerConfigObj = multer(configMulter);
var multerMiddleware = multerConfigObj.any();

app.use(bodyParser.json());
app.use(access);
app.use(session.use(db.get('session')));
app.post('/files', multerMiddleware, files);
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

function filename(req, file, cb) {
  var uid = req.session.find(req.ip);
  uid = 'a';
  var name = uid + '_' + file.originalname;
  cb(null, name);
}

function files(req, res) {
  var reqFiles = req.files;
  reqFiles.forEach(parseIt);

  function parseIt(gerberFile) {
    var filePath = gerberFile.path;
    parseGerberFile(filePath);

    function parseGerberFile(filePath) {
      var parser = gerberParser();
      parser.on('warning', warn);
    	fs.createReadStream(filePath, {encoding: 'utf8'})
    	  .pipe(parser)
    	   .on('data', test);

    	function test(obj) {
    		console.log(obj);
    	}

    	function warn(w) {
    		console.log('warning at line ' + w.line + w.message);
    	}
    }
  }
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
