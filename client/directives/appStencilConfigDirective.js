Directive.$inject = ['Restangular', '$compile'];

function Directive (Restangular, $compile) {
  var directive = {};
  directive.restrict = 'A';
  directive.controller = 'directiveAppStencilConfigController';
  directive.controllerAs = 'vm';
  directive.compile = compile;
  directive.priority = 2;

  function compile(elmnt, attrs) {
      /*var url = 'directive-app-stencil-config';
      Restangular.all(url).get('').then(handle);

      function handle(response) {
        var template = jQuery(response);
        elmnt.prepend(template);
      }*/

      function link(scope, element, attributes, controller) {
      }

      return link;
  }

  return directive;
}

var directiveName = 'appStencilConfig';
var appStencilConfigDirective = {};

appStencilConfigDirective.directiveName = directiveName;
appStencilConfigDirective.directive = Directive;

export var appStencilConfigDirective = appStencilConfigDirective;
