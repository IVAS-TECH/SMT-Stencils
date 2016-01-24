session = require "./../lib/session/session"

module.exports =
  beforeEach: session()
  user: require "./user/userHandle"
  login: require "./user/loginHandle"
  language: require "./user/language/languageHandle"
  configuration: require "./order/config/configHandle"
  addresses: require "./order/addresses/addressesHandle"
  description: require "./order/description/descriptionHandle"
  file: require "./order/file/fileHandle"
  order: require "./order/orderHandle"
