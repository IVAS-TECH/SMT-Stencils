directive = ->

  templateUrl: "textFieldView"
  scope: yes
  controller: "textFieldController"
  controllerAs: "textFieldCtrl"
  bindToController:
    label: "="
    text: "="
    index: "="
    texts: "="
    disabled: "="

directive.$inject = []

module.exports = directive
