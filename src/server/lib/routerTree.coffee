{Router} = require "express"
methods = ["get", "delete", "post", "put", "patch"]
special = ["params", "beforeEach", "afterEach", "use"]

routerLeaf = (handle) ->
    router = new Router()
    callbacks = []
    use = (wich) -> if handle[special[wich]]? then router.use "/", handle[special[wich]]
    use 1
    params = handle[special[0]]
    for own key, value of handle
        if key not in special
            if key not in methods then router.use "/" + key, routerLeaf value
            else
                uri = "\/"
                param = null
                if params?
                    if typeof params is "object"
                        if typeof params.callback is "function"
                            if params.callback not in callbacks
                                router.param params.name, params.callback
                                callbacks.push params.callback
                            param = params.name
                        if params[key]?
                            param = params[key]
                            if typeof param is "object"
                                router.param param.name, param.callback
                                param = param.name
                    if typeof params is "string" then param = params
                args = []
                if value instanceof Array then args.push arg for arg in value else args.push value
                args.unshift if param? then uri + ":" + param else uri
                router[key].apply router, args
    use 2
    router

module.exports = routerLeaf
