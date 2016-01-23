module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]

  (event, description, handle) ->
    showDialogService.showDialog event, "showDescription", description, handle
