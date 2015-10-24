import { config, controllers } from 'config';
import { directives } from 'appDirectives';

var moduleName = 'app';

function configTheme ($mdThemingProvider) {
  $mdThemingProvider
    .theme('appTheme')
      .primaryPalette('teal')
      .accentPalette('indigo')
      .warnPalette('red')
      .backgroundPalette('blue-grey')
      .dark()
      .dark();
}

angular
  .module(moduleName, ['ngRoute', 'ngMaterial', 'ngMessages', controllers.moduleName, directives.moduleName])
    .config(config)
    .config(configTheme);

export var app = moduleName;
