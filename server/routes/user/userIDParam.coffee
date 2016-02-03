module.exports = (req, res, next, id) ->
  req.userID = req.user.user
  if id isnt "id" then req.userID = id
  next()
