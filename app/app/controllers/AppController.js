class Controller {
  constructor() {
    var vm = this;
    vm.data = [3, 2, 1, 4, 5];

  }
}

var appController = {};

var config = {
      templateUrl: '/view-app',
      controller: appController.moduleName,
      controllerAs: 'vm'
};

appController.moduleName = 'appController';
appController.config = config;
appController.controller = Controller;

export var appController = appController;
