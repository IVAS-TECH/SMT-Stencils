directive = (template) ->

  template: template "fileContainerView"
  scope: yes
  controller: "fileContainerController"
  controllerAs: "fileCnrCtrl"
  bindToController:
    layer: "="
    order: "="
    remove: "="

directive.$inject = ["template"]

module.exports = directive
