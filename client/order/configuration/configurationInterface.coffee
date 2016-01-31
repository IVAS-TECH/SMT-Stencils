Promise = require "promise"

module.exports = ($controller, template, $scope, RESTHelperService, simpleDialogService, progressService, confirmService) ->
  @$inject = ["$controller", "template", "$scope", "RESTHelperService", "simpleDialogService", "progressService", "confirmService"]

  controller = $controller "baseInterface",
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "progressService": progressService
    "confirmService": confirmService
    "link": "configuration"
    "settings": @settings
    "exclude": ["text", "view", "options"]

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

  controller.options =
    side: ["pcb-side", "squeegee-side"]
    textPosition: textPosition()
    textAngle: textAngle()

  controller.changeStencilTransitioning = ->
    if not controller.configurationObject.stencil?
      controller.configurationObject.style.frame = no
    else
      controller.configurationObject.style.frame = (controller.configurationObject.stencil.transitioning.match /frame/)?

  controller.changeDimenstions = (stencil) ->

    stencil = controller.configurationObject.stencil

    if not stencil or stencil.width < 100 or stencil.height < 100
      controller.configurationObject.style.stencil = no
      return

    base =
      width: 115
      height: 145

    if controller.configurationObject.style.frame
      for prop in ["width", "height"]
        base[prop] += 70

    calculate = (wich) -> base[wich] + ((stencil[wich] - 90) / 9)

    controller.configurationObject.style.stencil =
      height: calculate "height"
      width: calculate "width"

  controller.textAngle = textAngle

  controller.changeText = (text) ->
    color = "pcb-side"
    angle = ""
    def = "text-top-left-left"
    text = controller.configurationObject.text
    if not text?
      controller.configurationObject.style.text = color: color, view: def
      return
    if text.type is "engraved" and text.side
      color = text.side
    if text.type is "drilled"
      color = text.type
    if not text.position?
      controller.configurationObject.style.text = color: color, view: def
      return
    if text.angle in controller.options.textAngle
      angle = text.angle
    else
      angle = controller.options.textAngle[0]
    controller.configurationObject.style.text =
      color: color
      view: ["text", text.position, angle].join "-"

  controller.changeStencilPosition = ->
    if not controller.configurationObject.position?
      controller.configurationObject.style.outline = no
      controller.configurationObject.style.layout = no
      controller.configurationObject.style.mode = "portrait-centered"
    else
      aligment = controller.configurationObject.position.aligment ? "portrait"
      position = controller.configurationObject.position.position
      mode = ""
      if position isnt "pcb-centered"
        controller.configurationObject.style.outline = no
        controller.configurationObject.style.layout = position is "layout-centered"
        if controller.configurationObject.style.layout
          mode = "centered"
        else mode = "no"
        controller.configurationObject.style.mode = [aligment, mode].join "-"
      else
        controller.configurationObject.style.outline = yes
        controller.configurationObject.style.layout = no
        controller.configurationObject.style.mode = [aligment, "centered"].join "-"

  controller.change = ->
    if not controller.configurationObject.style?
      controller.configurationObject.style = {}

  listen()

  controller
