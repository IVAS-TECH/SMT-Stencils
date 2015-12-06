{angular} = require "dependencies"

module.exports = (RESTHelperService, simpleDialogService, $state) ->

  init = ->
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
  controller.$inject = ["RESTHelperService", "simpleDialogService", "$state"]
  init()

  controller.reset = ->
      controller.disabled = false
      controller.action = "new"
      delete controller.config
      controller.configuration = {}
      controller.change()

  controller.change = ->
    controller.info = true
    position = ""
    if controller.configuration.text
         position = controller.configuration.text.position
    controller.options =
      side: ["pcb-side", "squeegee-side"]
      textAngle: textAngle position
      textPosition: textPosition()
    controller.changeText controller.configuration.text
    controller.changeStencilTransitioning()
    controller.changeStencilPosition()

  controller.choose = ->
    controller.disabled = true
    controller.action = "preview"
    controller.configuration = controller.configs[controller.config]
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
    if not controller.configuration.stencil?
      controller.frame = false
      return
    controller.frame = controller.configuration.stencil.transitioning.match /frame/

  controller.changeStencilPosition = ->
    if not controller.configuration.position?
      controller.outline = false
      controller.layout = false
      controller.mode = ["portrait", "centered"].join "-"
      return
    aligment = controller.configuration.position.aligment ? "portrait"
    position = controller.configuration.position.position
    mode = ""
    if position isnt "pcb-centered"
      controller.outline = false
      controller.layout = position is "layout-centered"
      if controller.layout
        mode = "centered"
      else mode = "no"
      controller.mode = [aligment, mode].join "-"
      return
    controller.outline = true
    controller.layout = false
    controller.mode = [aligment, "centered"].join "-"

  controller.configurationAction = (event, invalid) ->

    create = ->
      controller.configuration.stencil.size = controller.configuration.stencil.size ? "default"
      controller.configuration.text.side = controller.configuration.text.side ? "default"
      RESTHelperService.config.create config: controller.configuration, (res) ->
        if res.success then controller.configuration._id = res._id

    remove = ->
      RESTHelperService.config.delete controller.configuration._id, (res) ->
        console.log res.success


    if not invalid
      if controller.action is "new"
        if controller.save then create()
        $state.go "home.order.spesific"
      if controller.action is "preview" and not controller.settings
        $state.go "home.order.spesific"
      if controller.action is "delete" then remove()
    else simpleDialogService event, "required-fields"

  controller
