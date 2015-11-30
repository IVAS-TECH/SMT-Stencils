module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]
  (event, handle, title) ->
    console.log arguments
    showDialogService.showDialog event, "simpleDialog", (showDialogService.extendHandle handle, {
      "success": ->
      "close": ->
    }), title: title
