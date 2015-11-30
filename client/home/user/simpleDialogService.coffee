module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]
  (event, title, handle) ->
    showDialogService.showDialog event, "simpleDialog", (showDialogService.extendHandle handle, {
      "success": ->
      "close": ->
    }), title: title
