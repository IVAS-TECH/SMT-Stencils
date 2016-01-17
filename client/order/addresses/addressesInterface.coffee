module.exports = ($controller, $scope, RESTHelperService, simpleDialogService, progressService, confirmService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService", "simpleDialogService", "progressService", "confirmService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "progressService": progressService
    "confirmService": confirmService
    "link": "addresses"
    "settings": @settings

  controller = $controller "baseInterface", injectable

  controller.btnBack = yes

  listen = ->
    stop = $scope.$on "address-validity", (event, wich, value) ->
      index = -1
      switch wich
        when "delivery" then index = 0
        when "invoice" then index = 1
        when "firm" then index = 2
      controller.valid[index] = value
    $scope.$on "$destroy", stop

  controller.fill = (src, dst) ->
    info = [
      "country"
      "city"
      "postcode"
      "address1"
      "address2"
      "firstname"
      "lastname"
    ]
    for key in info
      controller.addressesObject[src][key] =  controller.addressesObject[dst][key]

  listen()

  controller
