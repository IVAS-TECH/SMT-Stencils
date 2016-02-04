service = (showDialogService) ->

  (dialog) ->
    (event, title, extend) ->
      showDialogService event, dialog, title: title, {}, extend

service.$inject = ["showDialogService"]

module.exports = service
