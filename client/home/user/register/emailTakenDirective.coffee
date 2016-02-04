Promise = require "promise"

directive = (RESTHelperService) ->

  restric: "A"
  require: "ngModel"
  link: (scope, element, attrs, ngModel) ->

    ngModel.$asyncValidators["email-taken"] = (newValue) ->

      new Promise (resolve, reject) ->

        RESTHelperService.user.email newValue, (res) ->

          if res.taken then reject() else resolve()

directive.$inject = ["RESTHelperService"]

module.exports = directive
