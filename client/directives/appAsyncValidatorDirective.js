function Directive () {
  var directive = {};

  directive.restrict = 'A';
  directive.require = 'ngModel';
  directive.link = link;

  function link (scope, element, attributes, ngModel) {
    var asyncValidator = scope.$eval(attributes[directiveName]);
    for(var key in asyncValidator)
      if(typeof asyncValidator[key] === 'function')
        ngModel.$asyncValidators[key] = asyncValidator[key];
  }

  return directive;
}

var directiveName = 'appAsyncValidator',
  appAsyncValidatorDirective = {};

appAsyncValidatorDirective.directiveName = directiveName;
appAsyncValidatorDirective.directive = Directive;

export var appAsyncValidatorDirective = appAsyncValidatorDirective;
