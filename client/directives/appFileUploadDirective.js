function Directive () {
  var directive = {},
    url = 'directive-app-file-upload';
  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = 'directiveAppFileUploadController';
  directive.controllerAs = 'vm';
  directive.bindToController = true;
  directive.scope = true;

  return directive;
}

var directiveName = 'appFileUpload',
  appFileUploadDirective = {};

appFileUploadDirective.directiveName = directiveName;
appFileUploadDirective.directive = Directive;

export var appFileUploadDirective = appFileUploadDirective;
