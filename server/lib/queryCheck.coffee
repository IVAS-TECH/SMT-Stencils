successful = require "./successful"
send = require "./send"

module.exports = (err, doc, res, next) ->
  if successful err, doc then send res
  else next err
