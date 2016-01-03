module.exports = (errorFile) ->
  (err, req, res, next) ->
    if err is "Not Found"
      res.status(200).sendFile errorFile
    else
      res.sendStatus 500
