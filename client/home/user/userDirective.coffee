directive = (template) ->

  template: template "userView"
  controller: "userController"
  controllerAs: "userCtrl"

directive.$inject = ["template"]

module.exports = directive
