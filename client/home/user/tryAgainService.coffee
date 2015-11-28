module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]
  (event, handle) -> showDialogService.showDialog event, "tryAgain", showDialogService.extendHandle handle, {
    "ok": ->
    "cancel": -> alert "errorService event"
    "close": -> alert "We hope to see you again..."
  }
