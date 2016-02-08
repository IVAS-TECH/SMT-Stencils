sessionMiddleware = require "./../lib/session/sessionMiddleware"
restrictMiddleware = require "./restrictMiddleware"
session = sessionMiddleware()

module.exports =
  beforeEach: [(session "get"), restrictMiddleware]
  user: require "./user/userHandle"
  login: require "./user/loginHandle"
  template: require "./templateHandle"
  visit: require "./user/visit/visitHandle"
  language: require "./user/languageHandle"
  addresses: require "./order/addresses/addressesHandle"
  description: require "./order/description/descriptionHandle"
  notification: require "./order/notification/notificationHandle"
  configuration: require "./order/configuration/configurationHandle"
  file: require "./order/file/fileHandle"
  order: require "./order/orderHandle"
  "response-error": require "./logResponseError"
  "client-error": require "./logClientError"
