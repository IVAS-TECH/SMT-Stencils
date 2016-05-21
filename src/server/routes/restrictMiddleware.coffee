module.exports = (req, res, next) ->
    if not req.user?
        isLogin = (req) -> req.url is "/login" and req.method is "GET" or req.method is "POST"
        isUser = (req) -> (req.url.match "/user")? and req.method is "POST" or req.method is "PUT"
        next if (isLogin req) or (isUser req) then undefined else new Error "Unauthorized Access"
    else next()
