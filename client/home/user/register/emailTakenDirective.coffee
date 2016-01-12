Promise = require "promise"

module.exports = (RESTHelperService) ->
  @$inject = ["RESTHelperService"]

  restric: "A"
  require: "ngModel"
  link: (scope, element, attrs, ngModel) ->

    ngModel.$asyncValidators["email-taken"] = (newValue) ->

      new Promise (resolve, reject) ->

        RESTHelperService.email newValue, (res) ->

          if res.taken then reject() else resolve()
