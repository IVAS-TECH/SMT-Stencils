module.exports = ($state, RESTHelperService, authenticationService, showNotificationService) ->
  @$inject = ["$state", "RESTHelperService", "authenticationService", "showNotificationService"]

  notifications = {}

  protect = off

  listening = null

  notificationFor: (order) -> notifications[order]

  notify: ->
    if not protect then protect = on
    if authenticationService.isAuthenticated() and not authenticationService.isAdmin()
      RESTHelperService.notification.find (res) ->
        if res.notifications and res.notifications.length
          notifications = {}
          for notification in res.notifications
            notifications[notification.order] = notification._id
          showNotificationService()

  listenForNotification: ->

    if not protect or $state.current.name isnt "home.orders" then @notify()

    listening = setInterval @notify, 60000

  stopListen: -> clearInterval listening

  reListenForNotification: ->
    @stopListen()
    @listenForNotification()
