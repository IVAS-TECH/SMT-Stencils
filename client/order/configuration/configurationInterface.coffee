Promise = require "promise"

module.exports = ($controller, template, $scope, RESTHelperService, simpleDialogService, progressService, confirmService) ->
  @$inject = ["$controller", "template", "$scope", "RESTHelperService", "simpleDialogService", "progressService", "confirmService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "progressService": progressService
    "confirmService": confirmService
    "link": "configuration"
    "settings": @settings

  controller = $controller "baseInterface", injectable

  textPosition = ->
    options = []
    directionX = ["left", "right", "center"]
    directionY = ["top", "bottom", "center"]
    for y in directionY
      for x in directionX
        options.push "#{y}-#{x}"
    options.pop()
    options

  textAngle = (position = "") ->
    if position.match /center-/
      return ["left", "right"]
    if position.match /-center/
      return ["bottom", "top"]
    ["left", "right", "bottom", "top"]

  listen = ->
    stop = $scope.$on "configuration-validity", (event, value) ->
      controller.valid = [value]
    $scope.$on "$destroy", stop

  controller.btnBack = no

  controller.text = "Text"

  controller.view = template "top"

  controller.style = {}

  controller.options =
    side: ["pcb-side", "squeegee-side"]
    textPosition: textPosition()
    textAngle: textAngle()

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
    if not text.position?
      return [color, def]
    if text.angle in controller.options.textAngle
      angle = text.angle
    else
      angle = controller.options.textAngle[0]
    [color, (["text", text.position, angle].join "-")]

  controller.changeStencilTransitioning = ->
    if not controller.configurationObject.stencil?
      controller.style.frame = no
    else
      controller.style.frame = (controller.configurationObject.stencil.transitioning.match /frame/)?

  controller.changeStencilPosition = ->
    if not controller.configurationObject.position?
      controller.style.outline = no
      controller.style.layout = no
      controller.style.mode = ["portrait", "centered"].join "-"
    else
      aligment = controller.configurationObject.position.aligment ? "portrait"
      position = controller.configurationObject.position.position
      mode = ""
      if position isnt "pcb-centered"
        controller.style.outline = no
        controller.style.layout = position is "layout-centered"
        if controller.style.layout
          mode = "centered"
        else mode = "no"
        controller.style.mode = [aligment, mode].join "-"
      else
        controller.style.outline = yes
        controller.style.layout = no
        controller.style.mode = [aligment, "centered"].join "-"

  controller.change = ->
    position = ""
    if controller.configurationObject.text?
         position = controller.configurationObject.text.position
    controller.options.textAngle =  controller.textAngle position
    controller.changeText controller.configurationObject.text
    controller.changeStencilTransitioning()
    controller.changeStencilPosition()

  listen()

  controller
