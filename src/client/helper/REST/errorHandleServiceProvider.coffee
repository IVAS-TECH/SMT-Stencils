provider = ->

  _resource = ""

  service = (RESTService) -> (res) -> if res? then (RESTService _resource) "post", res

  service.$inject = ["RESTService"]

  setResource: (resource) -> _resource = resource

  $get: service

provider.$inject = []

module.exports = provider
