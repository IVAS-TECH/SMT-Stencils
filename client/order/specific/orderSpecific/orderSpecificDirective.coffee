directive = ->

  templateUrl: "orderSpecificView"
  scope: yes
  controller: "orderSpecificController"
  controllerAs: "orderSpecificCtrl"
  bindToController:
    disabled: "="
    specific: "="

directive.$inject = []

module.exports = directive
