import { appController } from '/app/controllers/AppController.js';

var controllers = {
  moduleName : 'app.controllers',
  appController : appController
};

angular.module(controllers.moduleName, [])
    .controller(appController.moduleName, appController.controller);

export var controllers = controllers;
