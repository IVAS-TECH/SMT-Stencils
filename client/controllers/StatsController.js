import { default as reqLogin } from '/controllers/reqLogin.js'

function Controller() {
  var vm = this;
}

var moduleName = 'statsController';
var url = '/stats';

var resolve = {
  'reqLogin' : reqLogin
};

var config = {
  templateUrl : '/views/view-stats.html',
  controller : moduleName,
  controllerAs : 'vm',
  resolve : resolve
};

var statsController = {
  url : url,
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var statsController = statsController;
