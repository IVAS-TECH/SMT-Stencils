controller = ($rootScope, confirmService, RESTHelperService, simpleDialogService, stopLoadingService) ->
    ctrl = @
    stopLoadingService "profile"

    ctrl.change = (event, type, valid) ->
        if valid then confirmService event, success: ->
            send = id: "id", user: "#{type}": ctrl.user[type]
            RESTHelperService.user.profile send, (res) -> simpleDialogService event, "title-changed-#{type}"

    ctrl.remove = (event) -> confirmService event, success: ->
        RESTHelperService.user.remove "id", (res) ->
            simpleDialogService event, "title-account-deleted", success: ->
                $rootScope.$broadcast "remove-account"

    ctrl

controller.$inject = ["$rootScope", "confirmService", "RESTHelperService", "simpleDialogService", "stopLoadingService"]

module.exports = controller
