template = require "./template"

provider = -> provide: template, $get: -> template

provider.$inject = []

module.exports = provider
