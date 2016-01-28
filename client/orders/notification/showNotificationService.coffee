module.exports = (showDialogService, $state) ->
  @$inject = ["showDialogService", "$state"]

  (extend) ->
    showDialogService {}, "showNotification", {}, { success: -> $state.go "home.orders" }, extend
