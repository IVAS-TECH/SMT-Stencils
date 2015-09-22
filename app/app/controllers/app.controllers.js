import { appController } from '/app/controllers/AppController.js';
import { loginController } from '/app/controllers/LoginController.js';
import { registerController } from '/app/controllers/RegisterController.js';
import { statsController } from '/app/controllers/StatsController.js';

var controllers = {
  moduleName : 'app.controllers',
  appController : appController,
  loginController : loginController,
  registerController : registerController,
  statsController : statsController
};

angular.module(controllers.moduleName, [])
  .controller(appController.moduleName, appController.controller)
  .controller(loginController.moduleName, loginController.controller)
  .controller(registerController.moduleName, registerController.controller)
  .controller(statsController.moduleName, statsController.controller);

export var controllers = controllers;
