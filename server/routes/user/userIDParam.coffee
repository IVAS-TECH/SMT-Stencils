module.exports = (req, res, next, id) ->
  if not req.user? then next new Error "Unauthorized Access"
  else
    req.userID = req.user.user
    if id isnt "id" then req.userID = id
    next()
