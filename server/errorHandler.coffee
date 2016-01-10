module.exports = (errorFile) ->
  (err, req, res, next) ->
    if err is "Not Found"
      res.status(200).sendFile errorFile
    else
      console.log err
      res.sendStatus 500
