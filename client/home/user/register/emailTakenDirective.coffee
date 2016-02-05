directive = ($q, RESTHelperService) ->

  restric: "A"
  require: "ngModel"
  link: (scope, element, attrs, ngModel) ->

    ngModel.$asyncValidators["email-taken"] = (newValue) ->

      $q (resolve, reject) ->

        RESTHelperService.user.email newValue, (res) ->

          if res.taken then reject() else resolve()

directive.$inject = ["$q", "RESTHelperService"]

module.exports = directive
