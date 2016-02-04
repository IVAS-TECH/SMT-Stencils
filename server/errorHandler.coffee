module.exports = (errorStream, errorFile) ->
  (err, req, res, next) ->
    switch err.message
      when "Not Found" then (res.status 404).sendFile errorFile
      when "Unauthorized Access" then res.sendStatus 401
      else res.sendStatus 500
    errorStream.write err.stack, "utf-8"
