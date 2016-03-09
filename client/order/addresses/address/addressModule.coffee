{angular} = require "dependencies"
moduleName = "adressModule"

angular.module moduleName, []
  .constant "listOfCities", require "./listOfCities"
  .constant "listOfCountries", require "./listOfCountries"
  .controller "addressController", require "./addressController"
  .directive "ivstAddress", require "./addressDirective"
  #.config require "./addressConfig"

module.exports = moduleName