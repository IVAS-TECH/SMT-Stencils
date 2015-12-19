module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]
  (event, handle, title) -> showDialogService.showDialog event, "tryAgain", (showDialogService.extendHandle handle, {
    "success": ->
    "cancel": -> alert "errorService event"
  }), title: title
