module.exports = ->
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
  controller.$inject = []
  controller.text = "Text"
  controller.view = "'top'"
  controller.stencil = {style: {}}
  controller.options = {
    side: ["pcb-side", "squeegee-side"]
    textAngle: textAngle()
    textPosition: textPosition()
  }
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
    controller.frame = controller.stencil.transitioning.match /frame/
  controller.changeStencilPosition = ->
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
  controller
