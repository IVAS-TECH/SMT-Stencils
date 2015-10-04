import { controllers } from '/app.controllers.js';

config.$inject = ['$routeProvider'];

function config($routeProvider){
  $routeProvider
    .when('/', controllers.appController.config)
    .when('/login', controllers.loginController.config)
    .when('/register', controllers.registerController.config)
    .when('/stats', controllers.statsController.config)
    .otherwise({redirectTo: '/login'});
}

export var config = config;
export default { moduleName : controllers.moduleName };
