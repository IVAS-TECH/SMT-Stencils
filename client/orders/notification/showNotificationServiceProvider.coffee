provider = ->

  service = (showDialogService, $state) ->

    (state) ->
      (extend) ->
        showDialogService {}, "showNotification", {}, { success: -> $state.go state }, extend

  service.$inject = ["showDialogService", "$state"]

  $get: service

provider.$inject = []

module.exports = provider
