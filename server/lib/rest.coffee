{Router} = require "express"

module.exports = (rest, handle, param) ->

  router = new Router()

  for method, callback of handle
    uri = "\/" + rest
    if method in ["get", "delete"] and param?
      uri += "\/\:" + param
    router[method] uri, callback

  router
