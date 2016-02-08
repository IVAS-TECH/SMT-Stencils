controller = (RESTHelperService, statusOptions, confirmService, simpleDialogService) ->

  ctrl = @

  init = ->
    if ctrl.info.admin

      ctrl.adminPanel = "orderMenageView"
      ctrl.statusOptions = statusOptions

      RESTHelperService.language.find ctrl.info.user, (res) -> ctrl.info.language = res.language.language

  ctrl.action = (event) ->
    if ctrl.info.admin then RESTHelperService.order.update ctrl.info, (res) -> ctrl.hide "success"
    else ctrl.hide "success"

  init()

  ctrl

controller.$inject = ["RESTHelperService", "statusOptions", "confirmService", "simpleDialogService"]

module.exports = controller
