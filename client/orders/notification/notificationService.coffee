module.exports = ($state, RESTHelperService, authenticationService, showNotificationService) ->
  @$inject = ["$state", "RESTHelperService", "authenticationService", "showNotificationService"]

  notifications = {}

  notificationFor: (order) -> notifications[order]

  listenForNotification: ->

    notify = ->
      if authenticationService.isAuthenticated() and not authenticationService.isAdmin()
        RESTHelperService.notification.find (res) ->
          if res.notifications and res.notification.length
            notifications = {}
            for notification in res.notifications
              notifications[notification.order] = notification._id
            showNotificationService()

    if $state.current.name isnt "home.orders"
      notify()
    setInterval notify, 60000
