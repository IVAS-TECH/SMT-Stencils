function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;

  function link (scope, element, attributes) {
      element.css('float', 'right');
      element.css('position', 'relative');
  }

  return directive;
}

var directiveName = 'appFloatRight',
  appFloatRightDirective = {};

appFloatRightDirective.directiveName = directiveName;
appFloatRightDirective.directive = Directive;

export var appFloatRightDirective = appFloatRightDirective;
