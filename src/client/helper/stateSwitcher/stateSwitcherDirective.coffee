directive = ->

  templateUrl: "stateSwitcherView"
  scope: yes
  controller: "stateSwitcherController"
  controllerAs: "stateSwitcherCtrl"
  bindToController:
    state: "@"
    menu: "@"
    override: "<"
    remove: "<"

directive.$inject = []

module.exports = directive
