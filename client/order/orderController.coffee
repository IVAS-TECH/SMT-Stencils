module.exports = ->
  textPosition = ->
    options = []
    directionX = ["left", "right", "center"]
    directionY = ["top", "bottom", "center"]
    for i in [0..2]
      for j in [0..2]
        options.push "#{directionY[i]}-#{directionX[j]}"
    options
  textAngle = (pos) ->
    if not pos or not pos.match /center/
      return ["left", "right", "bottom", "top"]
    if pos.match /center-/
      return ["left", "right"]
    if pos.match /-center/
      return ["bottom", "top"]
  controller = @
  controller.$inject = []
  controller.stencil = {style: {}}
  controller.options = {
    side: ["pcb-side", "squeegee-side"]
    textAngle: textAngle ""
    textPosition: textPosition()
  }
  controller.textAngle = textAngle
  controller.changeText = (text) ->
    color = "pcb-side"
    angle = ""
    ret = []
    if not text?
      return [color, "text-top-left-left"]
    if text.type is "engraved" and text.side
      color = text.side
    if text.type is "drilled"
      color = text.type
    if not text.position
      return [color, "text-top-left-left"]
    if not text.angle? or not text.angle in controller.options.textAngle
      angle = controller.options.textAngle[0]
    else angle = text.angle
    return [color, ["text", text.position, angle].join "-"]
  controller.changeStencilTransitioning = ->
    controller.frame = controller.stencil.transitioning.match /frame/
  controller.changeStencilPosition = ->
    position = controller.stencil.position.position
    mode = ""
    if position isnt "pcb-centered"
      controller.stencil.style.out = false
      controller.stencil.style.lay = position is "layout-centered"
      if controller.stencil.style.lay
        mode = "centered"
      else mode = "no"
      controller.stencil.style.mode = [controller.stencil.position.aligment, mode].join "-"
      return
    controller.stencil.style.out = true
    controller.stencil.style.lay = false
    controller.stencil.style.mode = [controller.stencil.position.aligment, "centered"].join "-"
  controller
