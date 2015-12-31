module.exports = (template) ->
  @$inject = ["template"]

  template: template "stateSwitcherView"
  scope: true
  controller: "stateSwitcherController"
  controllerAs: "stateSwitcherCtrl"
  bindToController:
    state: "@"
    menu: "@"
    override: "="
    remove: "="
