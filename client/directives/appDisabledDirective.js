function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;

  function link (scope, element, attributes) {
      element.find('*').each(disable);

      function disable() {
        var bgColor = $(this).css('background-color');
        var color =  $(this).css('color');
        $(this).attr('disabled', 'disabled');
        $(this).css('color', color);
        $(this).css('background-color', bgColor);
        $(this).css('cursor', 'auto');
      }
  }

  return directive;
}

var directiveName = 'appDisabled',
  appDisabledDirective = {};

appDisabledDirective.directiveName = directiveName;
appDisabledDirective.directive = Directive;

export var appDisabledDirective = appDisabledDirective;
