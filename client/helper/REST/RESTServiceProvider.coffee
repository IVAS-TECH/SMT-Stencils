provider = ($httpProvider) ->

  $httpProvider.useApplyAsync yes

  _base = ""

  service = ($http) ->

    (resource) ->
      _url = _base + "/" + resource

      make = (method, data) ->
        url = _url
        if method in ["GET", "DELETE"] and data isnt "" then url += "/" + data
        request = url: url, method: method

        if typeof data is "object"
          request.headers = "Content-Type": "application/json"
          request.data = data

        $http request

      get: (send = "") -> make "GET", send
      post: (send = {}) -> make "POST", send
      put: (send = {}) -> make "PUT", send
      delete: (send = "") -> make "DELETE", send
      patch: (send = {}) -> make "PATCH", send

  service.$inject = ["$http"]

  setBase: (base) -> _base = base

  getBase: -> _base

  $get: service

provider.$inject = ["$httpProvider"]

module.exports = provider
