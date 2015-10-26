import { controllers as $controllers } from 'appControllers';

config.$inject = ['$stateProvider', '$mdThemingProvider'];

function config($stateProvider, $mdThemingProvider){
/*  $routeProvider
    .when($controllers.appController.url, $controllers.appController.config)
    .when('/login', {templateUrl : 'view-login'})
    .when($controllers.settingsController.url, $controllers.settingsController.config)
    .otherwise(root);*/

    $stateProvider
      .state('login', {
        templateUrl: 'view-login'
      })
      .state('user', {
        templateUrl: 'view-user'
      });


      //$rootScope.go = $state.go;

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
