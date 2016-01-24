module.exports = (template, populate) ->
  for index of template
    if (template[index].match /&@[a-z]/)?
      bind = populate[template[index].replace "&@", ""]
      if bind?
        template[index] = "" + bind
  template
