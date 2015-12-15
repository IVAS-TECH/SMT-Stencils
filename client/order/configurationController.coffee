{angular} = require "dependencies"

module.exports = (RESTHelperService, simpleDialogService, $state, $injector, $scope) ->

  init = ->
    controller.style = {}
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
  controller.$inject = ["RESTHelperService", "simpleDialogService", "$state", "$injector", "$scope"]
  init()

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

  controller.delete = (event) ->
      confirmService = $injector.get "confirmService"
      confirmService event, success: ->
        RESTHelperService.config.delete controller.configuration._id, (res) ->
          reset()
          $scope.$digest()

  controller.edit = ->
    controller.disabled = false
    controller.action = "edit"

  controller.doAction = (event, invalid) ->
    if not invalid
      if controller.action is "create"
        if controller.save
          RESTHelperService.config.create config: controller.configuration, (res) ->
            if res.success then controller.configuration._id = res._id
        if $state.current.name is "home.order.configuration"
          controller.next()
      if controller.action is "edit"
        confirmService = $injector.get "confirmService"
        confirmService event, success: ->
          RESTHelperService.config.update config: controller.configuration, (res) ->
    else simpleDialogService event, "required-fields"

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

  controller.next = ->
    $scope.$parent.orderCtrl.style = controller.style
    $scope.$parent.orderCtrl.configuration = controller.configuration
    $state.go "home.order.specific"

  controller
