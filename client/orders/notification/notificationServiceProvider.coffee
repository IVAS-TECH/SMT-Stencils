provider = ->

  _state = ""

  service = ($state, $rootScope, RESTHelperService, authenticationService, showNotificationService) ->

    notifications = {}

    listening = null

    showNotification = showNotificationService _state

    notificationFor: (order) -> notifications[order]

    notify: ->
      if authenticationService.isAuthenticated() and not authenticationService.isAdmin()
        RESTHelperService.notification.find (res) ->
          if res.notifications and res.notifications.length
            notifications = {}
            for notification in res.notifications
              notifications[notification.order] = notification._id
            extend = {}
            if $state.current.name is _state
              extend.success = -> $rootScope.$broadcast "notification"
            showNotification extend

    listenForNotification: ->

      setTimeout @notify, 10

      listening = setInterval @notify, 60000

    stopListen: -> clearInterval listening

    reListenForNotification: ->
      @stopListen()
      @listenForNotification()

  service.$inject = ["$state", "$rootScope", "RESTHelperService", "authenticationService", "showNotificationService"]

  $get: service

  setState: (_state) -> state = _state

  getState: -> _state

provider.$inject = []

module.exports = provider
