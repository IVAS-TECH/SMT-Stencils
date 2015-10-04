import {controllers } from '/app.controllers.js';

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

function run($location) {
  var login = false;
  login ? $location.path('/') : $location.path('/login');
}

run.$inject = ['$location'];

angular.module(moduleName, ['ngRoute', controllers.moduleName])
  .config(config)
  .run(run);

export var app = moduleName;
