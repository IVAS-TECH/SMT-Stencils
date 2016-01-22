module.exports = (showDialogService) ->
  @$inject = ["showDialogService"]

  (event, locals) ->

    showDialogService
      .showDialog event, "statistics", locals
