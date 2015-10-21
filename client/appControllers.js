import { appController } from 'AppController';
import { loginController } from 'LoginController';
import { registerController } from 'RegisterController';
import { settingsController } from 'SettingsController';

var moduleName = 'controllers',
  controllers = {};

controllers.moduleName = moduleName;
controllers.appController = appController;
controllers.loginController = loginController;
controllers.registerController = registerController;
controllers.settingsController = settingsController;

angular
  .module(controllers.moduleName, ['ngCookies', 'ngMessages', 'restangular'])
    .controller(appController.controllerName, appController.controller)
    .controller(loginController.controllerName, loginController.controller)
    .controller(registerController.controllerName, registerController.controller)
    .controller(settingsController.controllerName, settingsController.controller);

export var controllers = controllers;
