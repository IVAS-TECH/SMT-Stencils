directive = ->

  templateUrl: "stateSwitcherView"
  scope: true
  controller: "stateSwitcherController"
  controllerAs: "stateSwitcherCtrl"
  bindToController:
    state: "@"
    menu: "@"
    override: "="
    remove: "="

directive.$inject = []

module.exports = directive
