{angular} = require "dependencies"
moduleName = "helperModule"

angular
  .module moduleName, []
    .provider "template", require "./templateProvider"
    .service "stateSwitcherService", require "./stateSwitcherService"
    .provider "REST", require "./RESTProvider"
    .factory "RESTHelperService", require "./RESTHelperService"
    .config (RESTProvider) ->
      config = @
      config.$inject = ["RESTProvider"]
      RESTProvider.setBase "test"
    .run (RESTHelperService) ->
      run = @
      run.$inject = ["RESTHelperService"]
      RESTHelperService.test (r) -> alert r.data.test
      RESTHelperService.register user:{email: "t@t", password: "tttttt"}, (r) -> console.log r.data.user

module.exports = moduleName
