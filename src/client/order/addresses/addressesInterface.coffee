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
  ctrl.same = {}
  fields = ["country", "city", "postcode", "address1", "address2", "firstname", "lastname"]
  valids = ["delivery", "invoice", "firm"]

  listen = ->
    stopLoadingService "addresses"
    stop = $scope.$on "address-validity", (event, wich, value) -> ctrl.valid[valids.indexOf wich] = value
    $scope.$on "$destroy", stop

  ctrl.fill = (src, dst, same) ->
    if not ctrl.same[same] or not ctrl.addressesObject[src]? then ctrl.addressesObject[src] = {}
    else ctrl.addressesObject[src][field] = ctrl.addressesObject[dst][field] for field in fields

  listen()

  ctrl

controller.$inject = ["$controller", "$scope", "$q", "RESTHelperService", "simpleDialogService", "progressService", "confirmService", "stopLoadingService"]

module.exports = controller