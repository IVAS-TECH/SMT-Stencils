module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]
  (event, handle) -> showDialogService.showDialog event, "register", showDialogService.extendHandle handle, {
    "success": -> alert "loginService event"
    "fail": -> alert "errorService event"
    "close": -> alert "We hope to see you again..."
    "cancel": -> alert "Thank you fr trying..."
  }
