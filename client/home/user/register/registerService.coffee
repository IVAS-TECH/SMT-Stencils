service = (showDialogService, loginService) ->

  (event, extend) ->

    handle = "success": ->
      loginService event

    showDialogService event, "register", {}, handle, extend

service.$inject = ["showDialogService", "loginService"]

module.exports = service
