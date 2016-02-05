provider = ->

  _requests = {}

  service = (REST, uploadService, errorHandleService) ->

    handle = (req, arg) ->

      resolve = (resolver) ->
        (res) ->
          if res.status is 200 then resolver res.data
          else errorHandleService res

      if arg
        (argument, resolver) ->
          req(argument).then (resolve resolver), errorHandleService
      else
        (resolver) ->
          req().then (resolve resolver), errorHandleService

    requests = {}

    for key, value of _requests

      requests[key] = {}

      if key is "upload"

        for upload in value

          uploader = uploadService upload

          requests[key][upload] = handle uploader, yes

      else

        rest = REST key

        for index of value.arg
          requests[key][value.alias[index]] = handle rest[value.method[index]], value.arg[index]

    requests

  service.$inject = ["REST", "uploadService", "errorHandleService"]

  setRequets: (requests) -> _requests = requests

  $get: service

provider.$inject = []

module.exports = provider
