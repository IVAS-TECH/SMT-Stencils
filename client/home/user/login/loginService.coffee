module.exports = (showDialogService, tryAgainService, authenticationService) ->
  @$inject = ["showDialogService", "tryAgainService", "authenticationService"]
  login = (event, handle = {cancel: ->}) -> showDialogService.showDialog event, "login", showDialogService.extendHandle handle, {
    "success": (authentication) -> authenticationService.authenticate authentication
    "fail": -> tryAgainService event, (cancel: handle.cancel, success: -> login event, handle), "title-wrong-login"
    "close": -> alert "We hope to see you again..."
    "cancel": -> alert "Thank you fr trying..."
  }
  login
