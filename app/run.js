run.$inject = ['$location'];

function run($location) {
  var login = false;
  var path = location.pathname;
  if((path == '/register' || path == '/login') || login) {
    $location.path(path);
    return;
  }
    $location.path('/login');
}

export var run = run;
