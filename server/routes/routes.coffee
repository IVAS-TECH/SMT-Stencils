sessionMiddleware = require "./../lib/session/sessionMiddleware"

module.exports =
  beforeEach: sessionMiddleware "get"
  user: require "./user/userHandle"
  login: require "./user/loginHandle"
  visit: require "./user/visit/visitHandle"
  language: require "./user/language/languageHandle"
  addresses: require "./order/addresses/addressesHandle"
  description: require "./order/description/descriptionHandle"
  notification: require "./order/notification/notificationHandle"
  configuration: require "./order/configuration/configurationHandle"
  file: require "./order/file/fileHandle"
  order: require "./order/orderHandle"
