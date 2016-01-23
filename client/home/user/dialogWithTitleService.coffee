module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]

  (dialog) ->
    (event, title, extend) ->
      showDialogService event, dialog, title: title, {}, extend
