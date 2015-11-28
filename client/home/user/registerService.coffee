module.exports = (showDialogService, loginService) ->
  @$inject = ["showDialogService", "loginService"]
  (event, handle) -> showDialogService.showDialog event, "register", showDialogService.extendHandle handle, {
    "success": -> loginService event
    "fail": -> alert "errorService event"
    "close": -> alert "We hope to see you again..."
  }
