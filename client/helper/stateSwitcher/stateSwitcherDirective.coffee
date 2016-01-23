module.exports = (template) ->
  @$inject = ["template"]

  template: template "stateSwitcherView"
  scope: true
  controller: "stateSwitcherController"
  controllerAs: "stateSwitcherCtrl"
  bindToController:
    state: "@"
    override: "="
    remove: "="
