directive = ->

  templateUrl: "textFieldView"
  scope: {}
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
