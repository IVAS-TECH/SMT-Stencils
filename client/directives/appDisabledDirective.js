function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;

  function link (scope, element, attributes) {
      var color = element.css('background-color');
      element.attr('disabled', 'disabled');
      element.css('background-color', color);
      element.css('cursor', 'auto');
  }

  return directive;
}

var directiveName = 'appDisabled',
  appDisabledDirective = {};

appDisabledDirective.directiveName = directiveName;
appDisabledDirective.directive = Directive;

export var appDisabledDirective = appDisabledDirective;
