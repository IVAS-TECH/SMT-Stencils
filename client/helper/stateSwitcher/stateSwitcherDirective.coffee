module.exports = (template) ->
  directive = @
  directive.$inject = ["template"]
  template: template "stateSwitcherView"
  controller: "stateSwitcherController"
  controllerAs: "stateSwitcherCtrl"
