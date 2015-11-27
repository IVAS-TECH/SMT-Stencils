module.exports = ($mdDialog) ->
  service = @
  service.$inject = ["$mdDialog"]
  showDialog = (event, action) ->
    dialog = {
      template: template "#{action}View"
      targetEvent: event
      controller: "#{action}Controller"
      controllerAs: "#{action}Ctrl"
      clickOutsideToClose: true
    }
    $mdDialog.show(dialog)
    service.login = (event) -> showDialog event, "login"
    service.register = (event) -> showDialog event, "register"
