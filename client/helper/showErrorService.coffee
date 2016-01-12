module.exports = ->

  (obj) ->

    if typeof obj is "object" and obj?

      if Object.keys(obj).length then yes else no

    else no
