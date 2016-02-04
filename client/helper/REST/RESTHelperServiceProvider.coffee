provider = ->

  requests = {}

  service = (REST, uploadService, errorHandleService) ->

    handle = (req, arg) ->

      resolve = (resolver) ->
        (res) ->
          if res.status is 200
            resolver res.data
          else errorHandleService()

      if arg
        (argument, resolver) ->
          req(argument).then (resolve resolver), errorHandleService
      else
        (resolver) ->
          req().then (resolve resolver), errorHandleService

    rest = {}

    for key, value of requests

      rest[key] = {}

      if key is "upload"

        for upload in value

          uploader = uploadService upload

          rest[key][upload] = handle uploader, yes

      else

        rest = REST key

        for index of value.arg
          rest[key][value.alias[index]] = handle rest[value.method[index]], value.arg[index]

    rest

  service.$inject = ["REST", "uploadService", "errorHandleService"]

  setRequets: (reqsts) -> requests = reqsts

  $get: service

provider.$inject = []

module.exports = provider
