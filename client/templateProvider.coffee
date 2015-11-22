template = require "template"
angular = require "angular"
moduleName = "template"

angular
  .module moduleName, []
    .provider moduleName, ->
      provider = @
      provider.$get = -> template
      provider.provide = template
      provider

module.exports = moduleName
