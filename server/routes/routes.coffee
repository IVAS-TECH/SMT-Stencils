session = require "./../lib/session/session"

module.exports =
  beforeEach: session()
  user: require "./user/userHandle"
  login: require "./user/loginHandle"
  configuration: require "./order/config/configHandle"
  addresses: require "./order/addresses/addressesHandle"
  file: require "./order/file/fileHandle"
  order: require "./order/orderHandle"
