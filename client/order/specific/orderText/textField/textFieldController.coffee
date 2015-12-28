module.exports = ($scope) ->
  controller = @
  controller.$inject = ["$scope"]

  controller.action = (event) ->
    if event.keyCode is 13
      event.preventDefault()
      controller.texts.splice controller.index + 1, 0 , ""
    if event.keyCode is 8 and controller.index and not controller.text.length
      event.preventDefault()
      controller.texts.splice controller.index, 1

  controller
