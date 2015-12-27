module.exports = (template) ->
  @$inject = ["template"]
  template: template "addressView"
  controller: "addressController"
  controllerAs: "addressCtrl"
  scope:
    disabled: "="
    address: "="
    name: "@"
  link: (scope, element, attrs) ->
    
    stop = scope.$watch "address_.$invalid", (value) ->
      scope.$emit "address-validity", scope.name, value
    scope.$on "$destroy", stop
