provider = ($httpProvider) ->

  $httpProvider.useApplyAsync yes

  _base = ""

  service = ($http, $filter) ->

    (resource) ->
      url = _base + "/" + resource
      (method, data) ->
        $http
            method: method.toUpperCase()
            data: if ($filter "isntEmpty") data then data else undefined
            url: if method in ["get", "delete"] and typeof data is "string" then url + "/" + data else url

  service.$inject = ["$http", "$filter"]

  setBase: (base) -> _base = base

  getBase: -> _base

  $get: service

provider.$inject = ["$httpProvider"]

module.exports = provider
