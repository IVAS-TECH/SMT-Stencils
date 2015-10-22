import { controllers as $controllers } from 'appControllers';

config.$inject = ['$routeProvider'];

function config($routeProvider){
  $routeProvider
    .when($controllers.appController.url, $controllers.appController.config)
    .when($controllers.loginController.url, $controllers.loginController.config)
    .when($controllers.settingsController.url, $controllers.settingsController.config)
    .otherwise(root);
}

var root = {},
  controllers = {};

root.redirectTo = $controllers.appController.url;
controllers.moduleName = $controllers.moduleName;

export var config = config;

export var controllers = controllers;
