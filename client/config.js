import { controllers as $controllers } from 'appControllers';

config.$inject = ['$routeProvider', '$mdThemingProvider'];

function config($routeProvider, $mdThemingProvider){
  $routeProvider
    .when($controllers.appController.url, $controllers.appController.config)
    .when('/login', {templateUrl : 'view-login'})
    .when($controllers.settingsController.url, $controllers.settingsController.config)
    .otherwise(root);

    $mdThemingProvider
      .theme('appTheme')
        .primaryPalette('teal')
        .accentPalette('indigo')
        .warnPalette('red')
        .backgroundPalette('blue-grey')
        .dark()
        .dark();
}

var root = {},
  controllers = {};

root.redirectTo = $controllers.appController.url;
controllers.moduleName = $controllers.moduleName;

export var config = config;

export var controllers = controllers;
