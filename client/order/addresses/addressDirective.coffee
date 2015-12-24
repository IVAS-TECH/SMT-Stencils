module.exports = (template) ->
  @$inject = ["template"]
  template: template "addressView"
  controller: "addressController"
  controllerAs: "addressCtrl"
  scope:
    address: "="
    value: "="
    name: "@"
  link: (scope, element, attrs) ->
    if scope.value.country?
      for key, value of scope.value
        scope.address[key] = value
    stop = scope.$watch "address.$invalid", (value) ->
      scope.$emit "address-validity", scope.name, value
    scope.$on "$destroy", stop
