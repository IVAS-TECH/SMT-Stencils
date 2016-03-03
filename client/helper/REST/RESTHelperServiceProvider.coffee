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
    
    requests = upload: {}
    
    requests["upload"][upload] = handleUpload uploadService upload for upload in _requests.alias.upload
    
    delete _requests.alias.upload
    
    (aliasMap[name] = method for name in names) for method, names of _requests.alias
    
    delete _requests.alias

    for resource, apis of _requests
      requests[resource] = {}
      rest = RESTService resource
      requests[resource][api] = handle rest, aliasMap[api] for api in apis

    requests

  service.$inject = ["RESTService", "uploadService", "errorHandleService"]

  setRequets: (requests) -> _requests = requests

  $get: service

provider.$inject = []

module.exports = provider
