directive = (template) ->

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

directive.$inject = ["template"]

module.exports = directive
