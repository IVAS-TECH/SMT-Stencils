module.exports = (err, doc) ->
  if not doc? and not err?
    return true
  not err? and doc?
