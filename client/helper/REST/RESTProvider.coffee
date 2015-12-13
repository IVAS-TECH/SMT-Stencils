REST = require "./REST"

module.exports = ->
  base = ""
  
  setBase: (b) -> base = b
  $get: -> new REST base
