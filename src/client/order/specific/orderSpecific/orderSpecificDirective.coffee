directive = ->
    templateUrl: "orderSpecificView"
    scope:
        disabled: "="
        specific: "="
    link: (scope, element, attrs) ->
        scope.specific = scope.specific ? {}
        stop = scope.$watchCollection "specific", (specific) ->
            valid = specific.fudicals? and specific.dimenstions? and Object.keys(specific.dimenstions).length is 3
            scope.$emit "specific-validity", valid
        scope.$on "$destroy", stop

directive.$inject = []

module.exports = directive
