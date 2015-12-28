module.exports = (template) ->
  @$inject = ["template"]

  template: template "textFieldView"
  scope: true
  controller: "textFieldController"
  controllerAs: "textFieldCtrl"
  bindToController:
    disabled: "="
    bind: "="
