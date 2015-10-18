import { appController } from '/controllers/AppController.js';
import { loginController } from '/controllers/LoginController.js';
import { registerController } from '/controllers/RegisterController.js';
import { statsController } from '/controllers/StatsController.js';
import { directives } from '/app.directives.js'

var moduleName = 'controllers';

var controllers = {
  moduleName : moduleName,
  appController : appController,
  loginController : loginController,
  registerController : registerController,
  statsController : statsController
};

angular.module(controllers.moduleName, ['ngCookies', 'ngMessages', 'restangular', directives.moduleName])
  .controller(appController.moduleName, appController.controller)
  .controller(loginController.moduleName, loginController.controller)
  .controller(registerController.moduleName, registerController.controller)
  .controller(statsController.moduleName, statsController.controller);

export var controllers = controllers;
