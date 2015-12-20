module.exports = (RESTHelperService, simpleDialogService, $state, $scope, template) ->
  textPosition = ->
    options = []
    directionX = ["left", "right", "center"]
    directionY = ["top", "bottom", "center"]
    for x in directionX
      for y in directionY
        options.push "#{x}-#{y}"
    options

  textAngle = (position = "") ->
    if not position or not position.match /center/
      return ["left", "right", "bottom", "top"]
    if position.match /center-/
      return ["left", "right"]
    if position.match /-center/
      return ["bottom", "top"]

  controller = @
  controller.$inject = ["RESTHelperService", "simpleDialogService", "$state","$scope", "template"]
  controller.controller = "configCtrl"
  controller.text = "Text"
  controller.view = template "top"
  controller.style = {}
  controller.options =
    side: ["pcb-side", "squeegee-side"]
    textPosition: textPosition()
    textAngle: textAngle()

  controller.getConfigs = ->
    RESTHelperService.config.find (res) ->
        if res.success
          controller.configs = res.configs

  controller.reset = ->
      controller.disabled = false
      controller.action = "create"
      delete controller.config
      controller.configuration = {}
      controller.change()

  controller.change = ->
    position = ""
    if controller.configuration.text
         position = controller.configuration.text.position
    controller.options.textAngle =  textAngle position
    controller.changeText controller.configuration.text
    controller.changeStencilTransitioning()
    controller.changeStencilPosition()

  controller.choose = ->
    controller.disabled = true
    controller.action = "preview"
    controller.configuration = controller.configs[controller.config]
    controller.change()

  controller.create = ->

  controller.doAction = (event, invalid) ->
    if not invalid
      if controller.action is "create"
        controller.create()
      if controller.action is "edit"
        controller.update event
    else simpleDialogService event, "required-fields"

  controller.changeText = (text) ->
    color = "pcb-side"
    angle = ""
    def = "text-top-left-left"
    if not text?
      return [color, def]
    if text.type is "engraved" and text.side
      color = text.side
    if text.type is "drilled"
      color = text.type
    if not text.position
      return [color, def]
    if not text.angle? or not text.angle in controller.options.textAngle
      angle = controller.options.textAngle[0]
    else angle = text.angle
    return [color, ["text", text.position, angle].join "-"]

  controller.changeStencilTransitioning = ->
    if not controller.configuration.stencil?
      controller.style.frame = false
      return
    controller.style.frame = controller.configuration.stencil.transitioning.match /frame/

  controller.changeStencilPosition = ->
    if not controller.configuration.position?
      controller.style.outline = false
      controller.style.layout = false
      controller.style.mode = ["portrait", "centered"].join "-"
      return
    aligment = controller.configuration.position.aligment ? "portrait"
    position = controller.configuration.position.position
    mode = ""
    if position isnt "pcb-centered"
      controller.style.outline = false
      controller.style.layout = position is "layout-centered"
      if controller.style.layout
        mode = "centered"
      else mode = "no"
      controller.style.mode = [aligment, mode].join "-"
      return
    controller.style.outline = true
    controller.style.layout = false
    controller.style.mode = [aligment, "centered"].join "-"

  controller
