module.exports = (showDialogService, tryAgainService) ->
  @$inject = ["showDialogService", "tryAgainService"]

  (dialog, wrong, success) ->

    circular = (event, extend) ->

      handle =

        "success": success

        "fail": ->

          tryAgainService event, "title-wrong-#{wrong}", "success": ->
            circular event, extend

      showDialogService event, dialog, {}, handle, extend

    circular
