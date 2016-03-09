{angular} = require "dependencies"
moduleName = "priceInfoModule"

angular.module moduleName, []
  .directive "ivstPriceField", require "./priceField/priceFieldDirective"
  .directive "ivstPriceInfo", require "./priceInfoDirective"

module.exports = moduleName