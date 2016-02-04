directive = (template) ->
  
  template: template "stateSwitcherView"
  scope: true
  controller: "stateSwitcherController"
  controllerAs: "stateSwitcherCtrl"
  bindToController:
    state: "@"
    menu: "@"
    override: "="
    remove: "="

directive.$inject = ["template"]

module.exports = directive
