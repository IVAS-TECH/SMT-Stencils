directive = ->

  templateUrl: "baseView"
  restrict: "E"
  scope: yes
  controller: "@"
  name: "inherit"
  controllerAs: "baseCtrl"
  bindToController: settings: "="
  link: (scope, element, attrs, controller) ->
    controller[if controller.settings then "getObjects" else "restore"]()

directive.$inject = []

module.exports = directive
