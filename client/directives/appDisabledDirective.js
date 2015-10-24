function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;

  function link (scope, element, attributes) {
      element.attr('disabled', true);
      element.css('cursor', 'auto');
  }

  return directive;
}

var directiveName = 'appDisabled',
  appDisabledDirective = {};

appDisabledDirective.directiveName = directiveName;
appDisabledDirective.directive = Directive;

export var appDisabledDirective = appDisabledDirective;
