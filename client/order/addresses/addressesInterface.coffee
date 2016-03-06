controller = ($controller, $scope, $q, RESTHelperService, simpleDialogService, progressService, confirmService, stopLoadingService) ->

  ctrl = $controller "baseInterface",
    "$scope": $scope
    "$q": $q
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "progressService": progressService
    "confirmService": confirmService
    "link": "addresses"
    "settings": @settings
    "exclude": []
    "awaiting": []

  ctrl.btnBack = yes

  listen = ->
  
    stopLoadingService "addresses"
    
    stop = $scope.$on "address-validity", (event, wich, value) ->
      index = -1
      switch wich
        when "delivery" then index = 0
        when "invoice" then index = 1
        when "firm" then index = 2
      ctrl.valid[index] = value
      
    $scope.$on "$destroy", stop

  ctrl.fill = (src, dst) ->
    ctrl.addressesObject[src][key] =  ctrl.addressesObject[dst][key] for key in [
      "country"
      "city"
      "postcode"
      "address1"
      "address2"
      "firstname"
      "lastname"
    ]

  listen()

  ctrl

controller.$inject = ["$controller", "$scope", "$q", "RESTHelperService", "simpleDialogService", "progressService", "confirmService", "stopLoadingService"]

module.exports = controller
