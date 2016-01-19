module.exports = (template) ->
  @$inject = ["template"]

  template: template "fileContainerView"
  scope: yes
  controller: "fileContainerController"
  controllerAs: "fileCnrCtrl"
  bindToController:
    layer: "="
    order: "="
    remove: "="
