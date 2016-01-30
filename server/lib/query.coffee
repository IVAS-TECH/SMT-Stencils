send = require "./send"

successful = (err, doc) -> (noErr err) and doc?

noErr = (err) -> not err?

handle = (check) ->
  (err, doc, res, next, key) ->
    if check err, doc
      if key?
        send res, "#{key}": doc
      else send res
    else next err

module.exports =

  successful: successful

  noErr: noErr

  basicHandle: handle successful

  noErrHandle: handle noErr
