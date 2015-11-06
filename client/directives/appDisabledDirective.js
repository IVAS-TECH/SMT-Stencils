function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;

  function link(scope, element, attributes) {
      var watchValue = attributes[directiveName]
      var toDisable = scope.$eval(watchValue);
      var elmColor = element.css('color');
      var childColor = [];
      element.find('*').each(getColor);
      if((watchValue !== 'true') && (watchValue !== 'false'))
        scope.$watch(watchValue, change);
      disableIt();

      function getColor(i, val) {
        childColor[i] = $(this).css('color');
      }

      function disableIt() {
        disable(element);
        element.find('*').each(disable);
      }

      function change(newValue) {
        toDisable = newValue;
        disableIt();
      }

      function disable(index, element) {
        var current = !element ? index : $(this);
        var bgColor = current.css('background-color');
        var color =  toDisable ? (element ? childColor[index] : elmColor) : 'white';
        current.attr('disabled', 'disabled');
        current.css('color', color);
        current.css('background-color', bgColor);
        current.css('cursor', 'auto');
      }
  }

  return directive;
}

var directiveName = 'appDisabled',
  appDisabledDirective = {};

appDisabledDirective.directiveName = directiveName;
appDisabledDirective.directive = Directive;

export var appDisabledDirective = appDisabledDirective;
