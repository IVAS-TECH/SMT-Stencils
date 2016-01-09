module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]

  (dialog) ->
    (event, title, extend) ->
      showDialogService
        .showDialog event, dialog, title: title, {}, extend
