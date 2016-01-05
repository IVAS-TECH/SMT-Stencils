{Router} = require "express"

methods = [
  "get"
  "delete"
  "post"
  "put"
  "patch"
]

routerLeaf = (handle) ->

  router = new Router()

  param = handle.param

  for key, value of handle
    if key isnt "param"

      if key not in methods
        router.use "\/" + key, routerLeaf value

      else
        uri = "\/"
        if key in methods[0..1] and param?
          uri += "\:" + param

        router[key] uri, value

  router

module.exports = routerLeaf
