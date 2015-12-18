module.exports = (template) ->
  @$inject = ["template"]
  template: template "addressView"
  controller: "addressController"
  controllerAs: "addressCtrl"
  scope:
    address: "="
    name: "@"
