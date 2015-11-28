module.exports = (registerService, loginService) ->
  controller = @
  controller.$inject = ["registerService", "loginService"]
  controller.register = (event) -> registerService event
  controller.login = (event) -> loginService event
  controller
