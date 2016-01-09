module.exports = (showDialogService, loginService) ->
  @$inject = ["showDialogService", "loginService"]

  (event, extend) ->
    
    handle = "success": ->
      loginService event

    showDialogService
      .showDialog event, "register", {}, handle, extend
