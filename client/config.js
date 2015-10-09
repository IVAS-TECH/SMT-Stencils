import { controllers } from '/app.controllers.js';

config.$inject = ['$routeProvider'];

function config($routeProvider){
  $routeProvider
    .when(controllers.appController.url, controllers.appController.config)
    .when(controllers.loginController.url, controllers.loginController.config)
    .when(controllers.registerController.url, controllers.registerController.config)
    .when(controllers.statsController.url, controllers.statsController.config)
    .otherwise({ redirectTo: controllers.loginController.url });
}

export var config = config;
export default { moduleName : controllers.moduleName };
