module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]

  (dialog) ->
    (event, locals, handle) ->
      showDialogService event, dialog, locals, handle
