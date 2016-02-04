controller = ->

  ctrl = @

  ctrl.action = (event) ->
    if event.keyCode is 13
      event.preventDefault()
      ctrl.texts.splice ctrl.index + 1, 0 , ""
    if event.keyCode is 8 and ctrl.index and not ctrl.text.length
      event.preventDefault()
      ctrl.texts.splice ctrl.index, 1

  ctrl

controller.$inject = []  

module.exports = controller
