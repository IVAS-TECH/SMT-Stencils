module.exports = (registerService) ->
  controller = @
  controller.$inject = ["registerService"]
  controller.register = (event) -> registerService event, {}# add default handle
  controller
