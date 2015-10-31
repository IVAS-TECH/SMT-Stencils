function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;

  function link (scope, element, attributes) {
      var bgColor = element.css('background-color');
      var color =  element.css('color');
      element.attr('disabled', 'disabled');
      element.css('color', color);
      element.css('background-color', bgColor);
      element.css('cursor', 'auto');
  }

  return directive;
}

var directiveName = 'appDisabled',
  appDisabledDirective = {};

appDisabledDirective.directiveName = directiveName;
appDisabledDirective.directive = Directive;

export var appDisabledDirective = appDisabledDirective;
