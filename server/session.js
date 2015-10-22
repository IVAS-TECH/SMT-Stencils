var session = {};
session.use = use;
session.create = create;

function Session() {
  this.mapIp = mapIp;
  this.findKey = findKey;
  this.find = find;

  var normalize = 'ip',
      mapedIp = {},
      mapedKey = {};

  function mapIp (ip, map) {
    mapedIp[normalize + ip] = mapKey(map);
  }

  function mapKey(map) {
    var key = generateKey();
    mapedKey[key] = map;
    return key;
  }

  function generateKey() {
    var lowerCase = 'abcdefghijklmnopqrstuvwxyz',
      upperCase = lowerCase.toUpperCase(),
      nums = '0123456789',
      special = '$_',
      first = lowerCase + upperCase + special,
      rest = first + nums,
      firstKeySymb = first.charAt(Math.floor(Math.random() * first.length)),
      key = firstKeySymb;

    for(var i = 0; i < 32; ++i)
      key += rest.charAt(Math.floor(Math.random() * rest.length));

    if(mapedKey[key])
      return generateKey();

    return key;
  }

  function find(key) {
    return mapKey[key];
  }

  function findKey(ip) {
    var key = mapedIp[normalize + ip];
    key = key ? key : '';
    return key;
  }
}

function use() {
  return ip;

  function ip(req, res, next) {
    req.ip = req.connection.remoteAddress || req.connection._peername.address;
    next();
  }
}

function create() {
  return new Session();
}

module.exports = session;
