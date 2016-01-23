module.exports = (showDialogService, tryAgainService) ->
  @$inject = ["showDialogService", "tryAgainService"]

  (dialog, wrong, success) ->

    circular = (event, extend) ->

      handle =

        "success": success

        "fail": ->

          extendIt =
            "success": -> circular event, extend

          tryAgainService event, "title-wrong-#{wrong}", extendIt

      showDialogService event, dialog, {}, handle, extend

    circular
