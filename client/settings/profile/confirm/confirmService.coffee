module.exports = (showDialogService, tryAgainService) ->
  @$inject = ["showDialogService", "tryAgainService"]

  confirm = (event, extend) ->

    handle =

      "fail": ->

        extendIt =
          "success": -> confirm event, extend

        tryAgainService event, "title-wrong-password", extendIt

    showDialogService
      .showDialog event, "confirm", {}, handle, extend

  confirm
