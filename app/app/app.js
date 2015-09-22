import {controllers } from '/app/controllers/app.controllers.js';

var moduleName = 'app';

function config($routeProvider){
  $routeProvider
    .when('/', controllers.appController.config)
    .when('/login', controllers.loginController.config)
    .when('/register', controllers.registerController.config)
    .when('/stats', controllers.statsController.config)
    .otherwise({redirectTo: '/login'});
}

config.$inject = ['$routeProvider'];

angular.module(moduleName, ['ngRoute', controllers.moduleName])
  .config(config);

export var app = moduleName;
