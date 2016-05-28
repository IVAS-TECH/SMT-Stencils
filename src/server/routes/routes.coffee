sessionMiddleware = require "./../lib/session/sessionMiddleware"
restrictMiddleware = require "./restrictMiddleware"
logErrorHandle = require "./logErrorHandle"
sendFileHandle = require "./sendFileHandle"
{join} = require "path"

log = (file) -> join __dirname, "../logs/#{file}.log"

module.exports =
  beforeEach: [sessionMiddleware().get, restrictMiddleware]
  user: require "./user/userHandle"
  login: require "./user/loginHandle"
  log: sendFileHandle join __dirname, "../logs"
  visit: require "./user/visit/visitHandle"
  language: require "./user/languageHandle"
  addresses: require "./order/addresses/addressesHandle"
  description: require "./order/description/descriptionHandle"
  notification: require "./order/notification/notificationHandle"
  configuration: require "./order/configuration/configurationHandle"
  file: require "./order/file/fileHandle"
  order: require "./order/orderHandle"
  "response-error": logErrorHandle log "response"
  "client-error": logErrorHandle log "client"
