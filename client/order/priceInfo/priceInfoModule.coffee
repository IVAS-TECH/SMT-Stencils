{angular} = require "dependencies"
moduleName = "priceInfoModule"

angular.module moduleName, []
  .directive "ivoPriceField", require "./priceField/priceFieldDirective"
  .directive "ivoPriceInfo", require "./priceInfoDirective"

module.exports = moduleName
