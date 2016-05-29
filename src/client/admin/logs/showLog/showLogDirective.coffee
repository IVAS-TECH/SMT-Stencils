directive = ->
  templateUrl: "showLogView"
  restrict: "E"
  scope: {}
  bindToController: log: "@"
  controller: "showLogController"
  controllerAs: "showLogCtrl"

directive.$inject = []

module.exports = directive
