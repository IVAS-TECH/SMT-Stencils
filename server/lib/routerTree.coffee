{Router} = require "express"

methods = [
  "get"
  "delete"
  "post"
  "put"
  "patch"
]

special = [
  "params"
  "beforeEach"
  "afterEach"
  "use"
]

routerLeaf = (handle) ->

  router = new Router()

  use = (wich) ->
    if handle[special[wich]]?
      router.use "\/", handle[special[wich]]

  use 1

  params = handle[special[0]]

  for key, value of handle
    if key not in special

      if key not in methods
        router.use "\/" + key, routerLeaf value

      else
        uri = "\/"
        if key in methods[0..1] and params?
          param = null
          if typeof params is "object" and params[key]?
            param = params[key]
          if typeof params is "string"
            param = params
          if param? then uri += "\:" + param

        router[key] uri, value

  use 2

  router

module.exports = routerLeaf
