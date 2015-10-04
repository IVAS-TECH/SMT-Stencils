run.$inject = ['$location'];

function run($location) {
  var login = false;
  var register = '/register';
  if(location.pathname == register || login) {
    $location.path(register);
    return;
  }
    $location.path('/login');
}

export var run = run;
