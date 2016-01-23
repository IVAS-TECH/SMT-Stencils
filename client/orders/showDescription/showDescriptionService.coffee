module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]

  (event, description, handle) ->
    showDialogService event, "showDescription", description, handle
