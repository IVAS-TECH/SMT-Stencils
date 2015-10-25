import { appController } from 'AppController';
import { settingsController } from 'SettingsController';

var moduleName = 'controllers',
  controllers = {};

controllers.moduleName = moduleName;
controllers.appController = appController;
controllers.settingsController = settingsController;

angular
  .module(controllers.moduleName, ['restangular'])
    .controller(appController.controllerName, appController.controller)
    .controller(settingsController.controllerName, settingsController.controller);

export var controllers = controllers;
