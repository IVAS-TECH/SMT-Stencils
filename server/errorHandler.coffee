module.exports = (errorStream, errorFile) ->
  (err, req, res, next) ->
    switch err.message
      when "Not Found" then status = 404
      when "Unauthorized Access" then status = 401
      else status = 500
    (res.status status).send error: status, message: if status is 500 then "Internal Server Error" else err.message
    errorStream.write err.stack, "utf-8"
