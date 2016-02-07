module.exports = (errorStream, redirect) ->
  (err, req, res, next) ->
    switch err.message
      when "Not Found" then status = 404
      when "Unauthorized Access" then status = 401
      else
        status = 500
        err.message = "Internal Server Error"
    send = res.status status
    if status is 404 then send.redirect redirect
    else send.send  error: status, message: err.message
    errorStream.write "#{err.stack}\n", "utf-8"
