module.exports = (template) ->
  @$inject = ["template"]
  template: template "filesView"
  controller: "filesController"
  controllerAs: "filesCtrl"
  bindToController:
    files: "="
    remove: "="
