directive = ->

  templateUrl: "fileContainerView"
  scope: yes
  controller: "fileContainerController"
  controllerAs: "fileCnrCtrl"
  bindToController:
    layer: "="
    order: "="
    remove: "="

directive.$inject = []

module.exports = directive
