module.exports = ($mdDialog) ->
  controller = @
  controller.$inject = ["$mdDialog"]
  controller.hide = $mdDialog.hide
  controller
