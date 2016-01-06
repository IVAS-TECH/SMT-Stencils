{Router} = require "express"

methods = [
  "get"
  "delete"
  "post"
  "put"
  "patch"
]

special = [
  "param"
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

  param = handle[special[0]]

  for key, value of handle
    if key not in special

      if key not in methods
        router.use "\/" + key, routerLeaf value

      else
        uri = "\/"
        if key in methods[0..1] and param?
          withParam = null
          if typeof param is "object" and param[key]?
            withParam = param[key]
          if typeof param is "string"
            withParam = param
          if withParam? then uri += "\:" + withParam

        router[key] uri, value

  use 2

  router

module.exports = routerLeaf
