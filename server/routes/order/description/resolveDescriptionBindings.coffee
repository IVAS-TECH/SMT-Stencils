module.exports = (template, populate) ->
  for index of template
    if (template[index].match /&@[a-zA-Z]+/)?
      bind = populate[template[index].replace "&@", ""]
      if bind? then template[index] = "" + bind
  template