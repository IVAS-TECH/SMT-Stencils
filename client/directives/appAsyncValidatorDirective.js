function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.require = 'ngModel';
  directive.link = link;

  function link (scope, element, attributes, ngModel) {
    var asyncValidators = scope.$eval(attributes[directiveName]);
    for(var asyncValidator in asyncValidators)
      if(asyncValidators[asyncValidator][0] && (typeof asyncValidators[asyncValidator][1] === 'function'))
        if(asyncValidators[asyncValidator][0] === true)
          addAsyncValidator(asyncValidators[asyncValidator][0]);
        else
          scope.$watch(asyncValidators[asyncValidator][0], addAsyncValidator);

    function addAsyncValidator (newValue, oldValue) {
      if(newValue)
        ngModel.$asyncValidators[asyncValidator] = asyncValidators[asyncValidator][1];
    }
  }

  return directive;
}

var directiveName = 'appAsyncValidator';

var appAsyncValidatorDirective = {
  directiveName : directiveName,
  directive : Directive
};

export var appAsyncValidatorDirective = appAsyncValidatorDirective;
