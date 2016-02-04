{angular} = require "dependencies"
moduleName = "adressesModule"

angular
  .module moduleName, [require "./address/addressModule"]
    .controller "addressesInterface", require "./addressesInterface"
    .config require "./addressesConfig"

module.exports = moduleName
