Directive.$inject = ['Restangular', '$compile'];

function Directive (Restangular, $compile) {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;
  directive.priority = 9999;

  function link(scope, elmnt, attrs) {
    var url1 = 'directive-app-stencil-preview';
    Restangular.all(url1).get('').then(build1);

    var url2 = 'directive-app-stencil-config';
    Restangular.all(url2).get('').then(build2);

    function build2(response) {
      var template = jQuery(response);
      elmnt.append(template);
      $compile(template)(scope);
    }


    function build1(response) {
      var template = jQuery(response);
      var div = template.find('div');
      var body = jQuery(div[0]);
      var text = jQuery(div[1]);
      var stencil = template.find('img');

      body.css('width', '150px');
      body.css('height', '200px');

      text.css('top', '15%');
      text.css('left', '30%');
      text.css('right', '30%');
      text.css('color', 'white');
      text.css('transform', 'rotate(90deg)');

      stencil.css('bottom', '3%');
      stencil.css('right', '10%');

      elmnt.append(template);
      $compile(template)(scope);
    }

    elmnt.removeAttr('app-compile');
  }

  return directive;
}

var directiveName = 'appCompile';
var appCompileDirective = {};

appCompileDirective.directiveName = directiveName;
appCompileDirective.directive = Directive;

export var appCompileDirective = appCompileDirective;
