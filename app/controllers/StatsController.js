function Controller() {
  var vm = this;
}

var moduleName = 'statsController';

var config = {
  templateUrl : '/views/view-stats.html',
  controller : moduleName,
  controllerAs : 'vm'
};

var statsController = {
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var statsController = statsController;
