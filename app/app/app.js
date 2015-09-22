import {controllers } from '/app/controllers/app.controllers.js';

var moduleName = 'app';

function config($routeProvider){
  $routeProvider
    .when('/', controllers.appController.config)
}

var run = function ($location) {
    $location.path('/');


};


config.$inject = ['$routeProvider'];

angular.module(moduleName, ['ngRoute', controllers.moduleName])
  .config(config)
  .run(run);

export default moduleName;
