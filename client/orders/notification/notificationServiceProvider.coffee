provider = ->

  _state = ""

  service = ($state, $rootScope, $timeout, $interval, RESTHelperService, authenticationService, showNotificationService) ->

    notifications = {}

    listening = null

    notificationFor: (order) -> notifications[order]

    notify: ->
      if authenticationService.isAuthenticated() and not authenticationService.isAdmin()
        RESTHelperService.notification.find (res) ->
          if res.notifications and res.notifications.length
            notifications = {}
            notifications[notification.order] = notification._id for notification in res.notifications
            showNotificationService {}, {}, success: if $state.current.name is _state then -> $rootScope.$broadcast "notification" else -> $state.go _state

    listenForNotification: ->
      $timeout @notify, 10
      listening = $interval @notify, 60000

    stopListen: -> if listening? then $interval.cancel listening

  service.$inject = ["$state", "$rootScope", "$timeout", "$interval", "RESTHelperService", "authenticationService", "showNotificationService"]

  $get: service

  setState: (state) -> _state = state

  getState: -> _state

provider.$inject = []

module.exports = provider
