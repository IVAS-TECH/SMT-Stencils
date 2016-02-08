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
        if params?
          param = null
          paramFn = null
          if typeof params is "object"

            if typeof params.callback is "function"
              param = params.name
              router.param params.name, params.callback

            if params[key]?
              param = params[key]
              if typeof param is "object"
                router.param param.name, param.callback
                param = param.name

          else if typeof params is "string" then param = params

          if param? then uri += "\:" + param

        if value instanceof Array
          value.unshift uri
          router[key].apply router, value
        else router[key] uri, value

  use 2

  router

module.exports = routerLeaf
