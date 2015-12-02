module.exports = ->
  controller = @
  controller.$inject = []
  controller.stencil = {}
  controller.options = {
    side: ["pcb-side", "squeegee-side"]
  }
  controller
