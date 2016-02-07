module.exports = (req, res, next) ->
  if not req.user?
    if req.url is "/login" or (req.url.match "/user")? and req.method is "GET" or req.method is "POST" then next()
    else next new Error "Unauthorized Access"
  else next()
