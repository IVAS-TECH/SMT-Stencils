directive = ->
  templateUrl: "showLogView"
  restrict: "E"
  scope: yes
  bindToController: log: "@"
  controller: "showLogController"
  controllerAs: "showLogCtrl"

directive.$inject = []

module.exports = directive
