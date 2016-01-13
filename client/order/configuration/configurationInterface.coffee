Promise = require "promise"

module.exports = ($controller, template, $scope, RESTHelperService, simpleDialogService, progressService) ->
  @$inject = ["$controller", "template", "$scope", "RESTHelperService", "simpleDialogService", "progressService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "progressService": progressService
    "link": "configuration"

  controller = $controller "baseInterface", injectable

  textPosition = ->
    options = []
    directionX = ["left", "right", "center"]
    directionY = ["top", "bottom", "center"]
    for x in directionX
      for y in directionY
        options.push "#{y}-#{x}"
    options

  textAngle = (position = "") ->
    if not position or not position.match /center/
      return ["left", "right", "bottom", "top"]
    if position.match /center-/
      return ["left", "right"]
    if position.match /-center/
      return ["bottom", "top"]

  controller.text = "Text"
  controller.view = template "top"
  controller.style = {}
  controller.options =
    side: ["pcb-side", "squeegee-side"]
    textPosition: textPosition()
    textAngle: textAngle()

  controller.textAngle = textAngle

  controller.listen = ->
    stop = $scope.$on "config-validity", (event, value) ->
      controller.valid = [value]
    $scope.$on "$destroy", stop

  controller.change = ->
    position = ""
    if controller.configurationObject.text
         position = controller.configurationObject.text.position
    controller.options.textAngle =  textAngle position
    controller.changeText controller.configurationObject.text
    controller.changeStencilTransitioning()
    controller.changeStencilPosition()

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
    return [color, (["text", text.position, angle].join "-")].join " "

  controller.changeStencilTransitioning = ->
    if not controller.configurationObject.stencil?
      controller.style.frame = false
      return
    controller.style.frame = (controller.configurationObject.stencil.transitioning.match /frame/)?

  controller.changeStencilPosition = ->
    if not controller.configurationObject.position?
      controller.style.outline = false
      controller.style.layout = false
      controller.style.mode = ["portrait", "centered"].join "-"
      return
    aligment = controller.configurationObject.position.aligment ? "portrait"
    position = controller.configurationObject.position.position
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

  controller.listen()

  controller
