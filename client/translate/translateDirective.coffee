directive = (template) ->

  template: template "translateView"
  controller: "translateController"
  controllerAs: "translateCtrl"

directive.$inject = ["template"]

module.exports = directive
