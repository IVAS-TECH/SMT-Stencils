requests = require "./requests"

module.exports = (REST, uploadService, errorHandleService) ->
  @$inject = ["REST", "uploadService", "errorHandleService"]

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

  service = {}

  for key, value of requests

    service[key] = {}

    if key is "upload"

      for upload in value

        uploader = uploadService upload

        service[key][upload] = handle uploader, yes

    else

      rest = REST key

      for index of value.arg
        service[key][value.alias[index]] = handle rest[value.method[index]], value.arg[index]

  service
