module.exports = (showDialogService, loginService) ->
  @$inject = ["showDialogService", "loginService"]

  (event, extend) ->

    handle = "success": ->
      loginService event

    showDialogService event, "register", {}, handle, extend
