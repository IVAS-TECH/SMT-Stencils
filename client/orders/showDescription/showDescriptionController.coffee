controller = ($rootScope, RESTHelperService, statusOptions, confirmService, simpleDialogService) ->

  ctrl = @

  init = ->
    if ctrl.info.admin

      ctrl.adminPanel = "orderMenageView"
      ctrl.statusOptions = new Array.apply null, statusOptions
      ctrl.statusOptions.push "delete"

      RESTHelperService.language.find ctrl.info.user, (res) -> ctrl.info.language = res.language.language

  ctrl.action = (event) ->
    if ctrl.info.admin
      if ctrl.info.status is "delete"
        confirmService event, success: ->
          RESTHelperService.user.remove ctrl.info.user, (res) ->
            simpleDialogService event, "title-deleted", success: ->
              $rootScope.$broadcast "user-removed", ctrl.info.user
      else RESTHelperService.order.update ctrl.info, (res) ->
          simpleDialogService event, "title-order-status-updated"
    ctrl.hide "success"

  init()

  ctrl

controller.$inject = ["$rootScope", "RESTHelperService", "statusOptions", "confirmService", "simpleDialogService"]

module.exports = controller
