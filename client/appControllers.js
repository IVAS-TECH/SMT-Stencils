import { appController } from 'AppController';
import { loginController } from 'LoginController';
import { settingsController } from 'SettingsController';

var moduleName = 'controllers',
  controllers = {};

controllers.moduleName = moduleName;
controllers.appController = appController;
controllers.loginController = loginController;
controllers.settingsController = settingsController;

angular
  .module(controllers.moduleName, ['restangular'])
    .controller(appController.controllerName, appController.controller)
    .controller(loginController.controllerName, loginController.controller)
    .controller(settingsController.controllerName, settingsController.controller);

export var controllers = controllers;
