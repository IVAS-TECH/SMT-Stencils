module.exports = (showDialogService, tryAgainService, authenticationService) ->
  @$inject = ["showDialogService", "tryAgainService", 'authenticationService']
  login = (event, handle) -> showDialogService.showDialog event, "login", showDialogService.extendHandle handle, {
    "success": (user) -> authenticationService.authenticate user
    "fail": -> tryAgainService event, ok: -> login event, handle
    "close": -> alert "We hope to see you again..."
    "cancel": -> alert "Thank you fr trying..."
  }
  login
