function Directive() {
  return directive;

  var directive = {};
  directive.restrict = 'A';
  directive.require = 'ngModel';
  directive.link = link;

  function link (scope, element, attributes, ngModel) {
    var asyncValidators = scope.$eval(attributes[directiveName]);
    for(var asyncValidator in asyncValidators)
      if((typeof asyncValidators[asyncValidator][1] === 'function') && asyncValidators[asyncValidator][0])
        ngModel.$asyncValidators[asyncValidator] = asyncValidators[asyncValidator][0];
  }
}

var directiveName = 'appAsyncValidator';

var appAsyncValidatorDirective = {
  directiveName : directiveName,
  directive : Directive
};

export var appAsyncValidatorDirective = appAsyncValidatorDirective;
