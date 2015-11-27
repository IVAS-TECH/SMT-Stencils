module.exports = ($mdDialog, RESTHelperService) ->
  controller = @
  controller.$inject = ["$mdDialog", "RESTHelperService"]
  controller.hide = $mdDialog.hide
  controller.register = ->
  controller
