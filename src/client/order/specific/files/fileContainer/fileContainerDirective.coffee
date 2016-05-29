directive = ->

  templateUrl: "fileContainerView"
  scope: {}
  controller: "fileContainerController"
  controllerAs: "fileCnrCtrl"
  bindToController:
    layer: "="
    order: "="
    remove: "="

directive.$inject = []

module.exports = directive
