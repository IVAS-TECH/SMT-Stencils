module.exports = ($mdDialog, template) ->
  @$inject = ["$mdDialog", "template"]
  openDialog = (event, action) ->
    $mdDialog.show
      template: template "#{action}View"
      targetEvent: event
      controller: "#{action}Controller"
      controllerAs: "#{action}Ctrl"
      clickOutsideToClose: true
  showDialog = (event, action, handle) ->
    openDialog event, action
      .then (val) -> if handle["val"]? then handle["val"]()
