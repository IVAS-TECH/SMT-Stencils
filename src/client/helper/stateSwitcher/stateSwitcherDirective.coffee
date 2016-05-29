directive = ->

  templateUrl: "stateSwitcherView"
  scope: {}
  controller: "stateSwitcherController"
  controllerAs: "stateSwitcherCtrl"
  bindToController:
    state: "@"
    menu: "@"
    override: "<"
    remove: "<"

directive.$inject = []

module.exports = directive
