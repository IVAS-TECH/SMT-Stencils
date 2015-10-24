function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;

  function link (scope, element, attributes) {
      element.css('float', 'left');
      element.css('position', 'relative');
  }

  return directive;
}

var directiveName = 'appFloatLeft',
  appFloatLeftDirective = {};

appFloatLeftDirective.directiveName = directiveName;
appFloatLeftDirective.directive = Directive;

export var appFloatLeftDirective = appFloatLeftDirective;
