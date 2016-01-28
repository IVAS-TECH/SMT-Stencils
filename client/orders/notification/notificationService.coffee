module.exports = ($state, $rootScope, RESTHelperService, authenticationService, showNotificationService) ->
  @$inject = ["$state", "$rootScope", "RESTHelperService", "authenticationService", "showNotificationService"]

  notifications = {}

  listening = null

  notificationFor: (order) -> notifications[order]

  notify: ->
    if authenticationService.isAuthenticated() and not authenticationService.isAdmin()
      RESTHelperService.notification.find (res) ->
        if res.notifications and res.notifications.length
          notifications = {}
          for notification in res.notifications
            notifications[notification.order] = notification._id
          extend = {}
          if $state.current.name is "home.orders"
            extend.success = -> $rootScope.$broadcast "notification"
          showNotificationService extend

  listenForNotification: ->

    @notify()

    listening = setInterval @notify, 60000

  stopListen: -> clearInterval listening

  reListenForNotification: ->
    @stopListen()
    @listenForNotification()
