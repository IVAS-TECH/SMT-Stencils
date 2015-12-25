module.exports = (template) ->
  @$inject = ["template"]
  template: template "addressView"
  controller: "addressController"
  controllerAs: "addressCtrl"
  scope:
    disabled: "="
    address: "="
    value: "="
    name: "@"
  link: (scope, element, attrs) ->
    for key, value of scope.value
      scope.address[key] = value
    stop = scope.$watch "address.$invalid", (value) ->
      scope.$emit "address-validity", scope.name, value
    scope.$on "$destroy", stop
