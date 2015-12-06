{angular} = require "dependencies"

module.exports = (RESTHelperService, simpleDialogService, $scope) ->

  listConfigs = ->
    RESTHelperService.config.find (res) ->
      if res.success
        controller.configs = res.configs

  textPosition = ->
    options = []
    directionX = ["left", "right", "center"]
    directionY = ["top", "bottom", "center"]
    for i in [0..2]
      for j in [0..2]
        options.push "#{directionY[i]}-#{directionX[j]}"
    options

  textAngle = (position = "") ->
    if not position or not position.match /center/
      return ["left", "right", "bottom", "top"]
    if position.match /center-/
      return ["left", "right"]
    if position.match /-center/
      return ["bottom", "top"]

  controller = @
  controller.$inject = ["RESTHelperService", "simpleDialogService", "$scope"]
  controller.text = "Text"
  controller.view = "'top'"
  listConfigs()

  controller.reset = ->
      controller.action = "new"
      controller.stencil = style: {}
      controller.change()

  controller.change = ->
    position = ""
    if controller.stencil.text
         position = controller.stencil.text.position
    controller.options =
      side: ["pcb-side", "squeegee-side"]
      textAngle: textAngle position
      textPosition: textPosition()
    controller.changeText controller.stencil.text
    controller.changeStencilTransitioning()
    controller.changeStencilPosition()

  controller.choose = ->
    config = controller.configs[controller.config]
    config.style = {}
    controller.stencil = config
    controller.change()

  controller.textAngle = textAngle

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
    if not controller.stencil.stencil?
      controller.frame = false
      return
    controller.frame = controller.stencil.stencil.transitioning.match /frame/

  controller.changeStencilPosition = ->
    if not controller.stencil.position?
      controller.stencil.style.out = false
      controller.stencil.style.lay = false
      controller.stencil.style.mode = ["portrait", "centered"].join "-"
      return
    aligment = controller.stencil.position.aligment ? "portrait"
    position = controller.stencil.position.position
    mode = ""
    if position isnt "pcb-centered"
      controller.stencil.style.out = false
      controller.stencil.style.lay = position is "layout-centered"
      if controller.stencil.style.lay
        mode = "centered"
      else mode = "no"
      controller.stencil.style.mode = [aligment, mode].join "-"
      return
    controller.stencil.style.out = true
    controller.stencil.style.lay = false
    controller.stencil.style.mode = [aligment, "centered"].join "-"

  controller.configurationAction = (event, invalid) ->
    create = ->
      controller.stencil.stencil.size = controller.stencil.stencil.size ? "default"
      controller.stencil.text.side = controller.stencil.text.side ? "default"
      config = angular.copy controller.stencil
      delete config.style
      RESTHelperService.config.create config: config, (res) ->
        if res.success then controller.stencil._id = res._id

    if not invalid
      if controller.action is "new"  then create()
    else simpleDialogService event, "required-fields"

  controller
