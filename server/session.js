var session = {};
session.use = use;

function Session(store) {
  this.mapIp = mapIp;
  this.find = find;
  this.unMapIp = unMapIp;
  this.isMapedIp = isMapedIp;
  init(store);

  var normalize = 'ip',
      mapedIp = {};

  function mapIp (ip, map) {
    var session = {};
    var _ip = normalize + ip;
    session.ip = _ip;
    session.map = map;
    store.insert(session);
    mapedIp[_ip] = map;
  }

  function find(ip) {
    return mapedIp[normalize + ip];
  }

  function unMapIp(ip) {
    var wich = {};
    var _ip = normalize + ip;
    wich.ip = _ip;
    store.remove(wich);
    delete mapedIp[_ip];
  }

  function isMapedIp(ip) {
    return mapedIp[normalize + ip] ? true : false;
  }

  function init(store) {
    store.find({}, found);

    function found(err, doc) {
      if(!err && doc)
        doc.forEach(map);

      function map(item) {
        mapedIp[item.ip] = item.map;
      }
    }
  }
}

function use(store) {
  var sessObj = new Session(store);

  function ip(req, res, next) {
    req.ip = req.connection.remoteAddress || req.connection._peername.address;
    req.session = sessObj;
    next();
  }

  return ip;
}

module.exports = session;
