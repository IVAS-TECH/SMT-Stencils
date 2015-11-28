module.exports = (showDialogService, tryAgainService) ->
  @$inject = ["showDialogService", "tryAgainService"]
  login = (event, handle) -> showDialogService.showDialog event, "login", showDialogService.extendHandle handle, {
    "success": -> alert "LOGIN"
    "fail": -> tryAgainService event, ok: -> login event, handle
    "close": -> alert "We hope to see you again..."
    "cancel": -> alert "Thank you fr trying..."
  }
  login
