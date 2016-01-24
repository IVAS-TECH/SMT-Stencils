module.exports = (showDialogService, $state) ->
  @$inject = ["showDialogService", "$state"]

  (stop) ->

    showDialogService null, "showNotification", {}, success: ->
      stop()
      $state.go "home.orders", {}, reload: yes
