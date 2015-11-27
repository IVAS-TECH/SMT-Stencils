module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]
  (event, handle) -> showDialogService event, "register", handle
