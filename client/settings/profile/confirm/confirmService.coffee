module.exports = (circularDialogService) ->
  @$inject = ["circularDialogService"]

  circularDialogService "confirm", "password"
