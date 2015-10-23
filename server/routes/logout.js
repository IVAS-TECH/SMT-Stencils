function logout(req, res, next) {
  req.session.unMapIp(req.ip);
}

module.exports = logout;
