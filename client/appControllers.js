import { viewUserController } from 'viewUserController';

var moduleName = 'appControllers',
  appControllers = {};

appControllers.moduleName = moduleName;

angular
  .module(moduleName, [])
    .controller(viewUserController.controllerName, viewUserController.controller);

export var appControllers = appControllers;
