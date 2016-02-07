module.exports = (res, obj = {}) ->
  res.setHeader "Cache-Control", "public, max-age=600" 
  (res.status 200).send obj
