provider = ->

  _requests = {}

  service = (RESTService, uploadService, errorHandleService) ->

    handle = (req, arg) ->

      resolve = (resolver) ->
        (res) ->
          if res.status is 200 and resolver? then resolver res.data
          else errorHandleService res

      if arg then (argument, resolver) -> req(argument).then (resolve resolver), errorHandleService
      else (resolver) -> req().then (resolve resolver), errorHandleService

    requests = {}

    for key, value of _requests
      requests[key] = {}
      if key is "upload" then requests[key][upload] = handle (uploadService upload), yes for upload in value
      else
        rest = RESTService key
        requests[key][value.alias[index]] = handle (rest value.method[index]), value.arg[index] for index of value.arg

    requests

  service.$inject = ["RESTService", "uploadService", "errorHandleService"]

  setRequets: (requests) -> _requests = requests

  $get: service

provider.$inject = []

module.exports = provider
