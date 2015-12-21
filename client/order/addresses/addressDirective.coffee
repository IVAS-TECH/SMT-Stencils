module.exports = (template) ->
  @$inject = ["template"]
  template: template "addressView"
  controller: "addressController"
  controllerAs: "addressCtrl"
  scope:
    address: "="
    name: "@"
  link: (scope, element, attrs) ->
    scope.$watch "address.$invalid", (value) ->
      scope.$emit "address-validity", scope.name, value
