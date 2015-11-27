module.exports = (registerService) ->
  controller = @
  controller.$inject = ["registerService"]
  controller.register = (event) -> registerService event, {}
  controller
