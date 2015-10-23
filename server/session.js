var session = {};
session.use = use;

function Session() {
  this.mapIp = mapIp;
  this.find = find;
  this.unMapIp = unMapIp;
  this.isMapedIp = isMapedIp;

  var normalize = 'ip',
      mapedIp = {};

  function mapIp (ip, map) {
    mapedIp[normalize + ip] = map;
  }

  function find(ip) {
    return mapedIp[normalize + ip];
  }

  function unMapIp(ip) {
    delete mapedIp[normalize + ip];
  }

  function isMapedIp(ip) {
    return mapedIp[normalize + ip] ? true : false;
  }
}

function use() {
  var sessObj = new Session();

  function ip(req, res, next) {
    req.ip = req.connection.remoteAddress || req.connection._peername.address;
    req.session = sessObj;
    next();
  }

  return ip;
}

module.exports = session;
