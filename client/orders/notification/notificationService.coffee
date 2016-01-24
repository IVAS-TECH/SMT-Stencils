module.exports = (RESTHelperService, authenticationService, showNotificationService) ->
  @$inject = ["RESTHelperService", "authenticationService", "showNotificationService"]

  notifications = {}

  notificationFor: (order) ->
    notification = notifications[order]

    notification is yes

  listenForNotification: ->

    notify = ->
      if authenticationService.isAuthenticated() and not authenticationService.isAdmin()
        RESTHelperService.notification.find (res) ->
          console.log res
          if res.notifications?
            notifications = {}
            for notification in res.notifications
              notifications[notification.order] = yes
            showNotificationService()

    setInterval notify, 6000
