provider = ($httpProvider) ->

  $httpProvider.useApplyAsync yes

  _base = ""

  service = ($http) ->

    (resource) ->
      _url = "#{_base}/#{resource}"

      rest = make: (method, data) ->
        url = _url
        if method in ["GET", "DELETE"] and data isnt "" then url += "\/" + data
        request = url: url, method: method

        if typeof data is "object"
          request.headers = "Content-Type": "application/json"
          request.data = data

        $http request

      rest.get = (send = "") -> rest.make "GET", send
      rest.post = (send = {}) -> rest.make "POST", send
      rest.put = (send = {}) -> rest.make "PUT", send
      rest.delete = (send = "") -> rest.make "DELETE", send
      rest.patch = (send = {}) -> rest.make "PATCH", send

      rest

  service.$inject = ["$http"]

  setBase: (base) -> _base = base

  getBase: -> _base

  $get: service

provider.$inject = ["$httpProvider"]

module.exports = provider
