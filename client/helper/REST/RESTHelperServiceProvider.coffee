provider = ->

  _requests = {}

  service = (RESTService, uploadService, errorHandleService) ->
  
    resolve = (res) -> (resp) -> if resp.status is 200 and res? then res resp.data else errorHandleService resp
  
    handleUpload = (req) -> (arg, res) -> (req arg).then (resolve res), errorHandleService

    handle = (req, method) ->
        (arg, res) ->
            if typeof arg is "function" then (req method).then (resolve arg), errorHandleService
            else (req method, arg).then (resolve res), errorHandleService
    
    aliasMap = {}
    
    (aliasMap[name] = method for name in names) for method, names of _requests.alias
    
    delete _requests.alias

    requests = {}

    for key, value of _requests
      requests[key] = {}
      if key is "upload" then requests[key][upload] = handleUpload uploadService upload for upload in value
      else
        rest = RESTService key
        requests[key][api] = handle rest, aliasMap[api] for api in value

    requests

  service.$inject = ["RESTService", "uploadService", "errorHandleService"]

  setRequets: (requests) -> _requests = requests

  $get: service

provider.$inject = []

module.exports = provider
