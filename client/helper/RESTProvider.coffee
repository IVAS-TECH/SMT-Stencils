REST = require "./REST"

module.exports = ->
  provider = @
  base = ""
  provider.setBase = (b) ->
    base = b
    provider
  provider.$get = -> new REST base
  provider
