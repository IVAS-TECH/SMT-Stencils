module.exports = (req, res, next) ->
  if not req.user?

    checkForLogin = (req) ->
      req.url is "/login" and req.method is "GET" or req.method is "POST"

    checkForUser = (req) ->
      (req.url.match "/user")? and req.method is "POST" or req.method is "PUT"

    if (checkForLogin req) or (checkForUser req) then next()
    else next new Error "Unauthorized Access"

  else next()
