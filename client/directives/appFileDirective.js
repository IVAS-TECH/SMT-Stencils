function Directive () {
  var directive = {};
  var url = 'directive-app-file';
  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.scope = {};
  directive.scope.name = '@';

  return directive;
}

var directiveName = 'appFile';
var appFileDirective = {};

appFileDirective.directiveName = directiveName;
appFileDirective.directive = Directive;

export var appFileDirective = appFileDirective;
