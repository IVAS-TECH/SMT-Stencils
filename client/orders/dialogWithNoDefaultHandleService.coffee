service = (showDialogService) ->

  (dialog) ->
    (event, locals, handle) ->
      showDialogService event, dialog, locals, handle

service.$inject = ["showDialogService"]

module.exports = service
