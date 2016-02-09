provider = ->

  _resource = ""

  service = (RESTService) ->

    (res) ->
      sender = RESTService _resource
      sender.post res

  service.$inject = ["RESTService"]

  setResource: (resource) -> _resource = resource

  $get: service

provider.$inject = []

module.exports = provider
