module.exports = ->

  separator = "\/"

  $get: ->
    format: @formater()
    parse: @parser()

  formater: ->
    (date) ->
      (date["get" + what]() for what in ["Day", "Date", "FullYear"]).join separator

  parser: ->
    (date) ->
      info = date.split separator
      new Date info[2], info[1], info[0]
