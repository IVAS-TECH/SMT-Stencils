module.exports = (showDialogService, tryAgainService) ->
  @$inject = ["showDialogService", "tryAgainService"]
  confirm = (event, handle) -> showDialogService.showDialog event, "confirm", showDialogService.extendHandle handle, {
    "success": ->
    "fail": -> tryAgainService event, (success: -> confirm event, handle), "title-wrong-password"
    "close": -> alert "We hope to see you again..."
    "cancel": -> alert "Thank you fr trying..."
  }
  confirm
