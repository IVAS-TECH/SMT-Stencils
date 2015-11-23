template = require "./template"

module.exports = ->
  provider = @
  provider.$get = -> template
  provider.provide = template
  provider
