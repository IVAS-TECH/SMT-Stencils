send = require "./send"

module.exports =

  successful: (err, doc) -> (@noErr err) and doc?

  noErr: (err) -> not err?

  basicHandle: (err, doc, res, next, key) ->
    if @successful err, doc
      if key?
        send res, "#{key}": doc
      else send res
    else next err

  noErrHandle: (err, res, next, doc, key) ->
    if @noErr err
      if key?
        send res, "#{key}": doc
      else send res
    else next err
