module.exports = (req, res, next, id) ->
    if not req.user? then next new Error "Unauthorized Access"
    else
        req.userID = if id is "id" then req.user.user else id
        next()
