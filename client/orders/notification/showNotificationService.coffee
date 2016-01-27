module.exports = (showDialogService, $state) ->
  @$inject = ["showDialogService", "$state"]

  ->
    showDialogService {}, "showNotification", {}, success: -> $state.go "home.orders"
