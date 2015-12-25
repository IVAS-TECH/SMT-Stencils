module.exports = ->
  controller = @

  controller.columns = ->
    for i in [7..1]
      if controller.files.length % i is 0
        controller.rows = [1..i]
        return [1..controller.files.length / i]

  controller.removeFile = (event, index) ->
    if controller.remove
      event.stopPropagation()
      controller.files.splice index, 1

  controller.fileName = (index) ->
    file = controller.files[index]
    if typeof file is "object"
      return file.name
    else
      return (file.split "___")[2]

  controller
