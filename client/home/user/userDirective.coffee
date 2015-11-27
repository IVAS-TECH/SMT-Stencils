module.exports = (template) ->
  directive = @
  directive.$inject = ["template"]
  template: template "userView"
  controller: "userController"
  controllerAs: "userCtrl"
