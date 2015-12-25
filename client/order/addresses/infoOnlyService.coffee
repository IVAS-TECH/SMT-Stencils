module.exports = ->

  (info) ->

    validInfo = (object) ->
      valid = {}

      for key, value of object
        if not key.match /\$/
          valid[key] = value

      valid

    result = {}

    for k, v of info
      if typeof v is "object"
        result[k] = validInfo v
      else result[k] = v

    result
