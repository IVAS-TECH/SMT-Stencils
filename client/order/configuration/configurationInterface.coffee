controller = ($controller, $scope, $q, RESTHelperService, simpleDialogService, progressService, confirmService, stopLoadingService) ->

  ctrl = $controller "baseInterface",
    "$scope": $scope
    "$q": $q
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "progressService": progressService
    "confirmService": confirmService
    "link": "configuration"
    "settings": @settings
    "exclude": []
    "awaiting": ["view"]

  textPosition = ->
    options = []
    directionX = ["left", "right", "center"]
    directionY = ["top", "bottom", "center"]
    (options.push y + "-" + x for x in directionX) for y in directionY
    options.pop()
    options

  textAngle = (position = "") ->
    if position.match /center-/ then return ["left", "right"]
    if position.match /-center/ then return ["bottom", "top"]
    ["left", "right", "bottom", "top"]

  listen = ->

    RESTHelperService.template.fetch "top.html", (res) ->
      ctrl.view = res
      stopLoadingService "configuration"

    stop = $scope.$on "configuration-validity", (event, value) -> ctrl.valid = [value]

    $scope.$on "$destroy", stop

  ctrl.btnBack = no

  ctrl.text = "Text"

  ctrl.options =
    side: ["pcb-side", "squeegee-side"]
    textPosition: textPosition()
    textAngle: textAngle()

  ctrl.changeStencilTransitioning = ->
    if not ctrl.configurationObject.stencil? then ctrl.configurationObject.style.frame = no
    else ctrl.configurationObject.style.frame = (ctrl.configurationObject.stencil.transitioning.match /frame/)?

  ctrl.textAngle = -> ctrl.options.textAngle = textAngle ctrl.configurationObject.text.position

  ctrl.changeText = (text) ->
    color = "pcb-side"
    def = "text-top-left-left"
    text = ctrl.configurationObject.text
    if not text?
      ctrl.configurationObject.style.text = color: color, view: def
      return
    if text.type is "engraved" and text.side then color = text.side
    if text.type is "drilled" then color = text.type
    if not text.position?
      ctrl.configurationObject.style.text = color: color, view: def
      return
    angle = if text.angle in ctrl.options.textAngle then text.angle else ctrl.options.textAngle[0]
    ctrl.configurationObject.style.text = color: color, view: "text-" + text.position + "-" + angle

  ctrl.changeStencilPosition = ->
    if not ctrl.configurationObject.position?
      ctrl.configurationObject.style.outline = no
      ctrl.configurationObject.style.layout = no
      ctrl.configurationObject.style.mode = "portrait-centered"
    else
      aligment = ctrl.configurationObject.position.aligment ? "portrait"
      position = ctrl.configurationObject.position.position
      if position isnt "pcb-centered"
        ctrl.configurationObject.style.outline = no
        ctrl.configurationObject.style.layout = position is "layout-centered"
        mode = if ctrl.configurationObject.style.layout then "centered" else "no"
        ctrl.configurationObject.style.mode = aligment + "-" + mode
      else
        ctrl.configurationObject.style.outline = yes
        ctrl.configurationObject.style.layout = no
        ctrl.configurationObject.style.mode = aligment + "-centered"

  ctrl.change = -> if not ctrl.configurationObject.style? then ctrl.configurationObject.style = {}

  listen()

  ctrl

controller.$inject = ["$controller", "$scope", "$q", "RESTHelperService", "simpleDialogService", "progressService", "confirmService", "stopLoadingService"]

module.exports = controller
