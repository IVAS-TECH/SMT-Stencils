module.exports = (template) ->
  @$inject = ["template"]

  template: template "textFieldView"
  scope: yes
  controller: "textFieldController"
  controllerAs: "textFieldCtrl"
  bindToController:
    label: "="
    text: "="
    index: "="
    texts: "="
    disabled: "="
