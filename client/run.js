run.$inject = ['$rootScope', '$state', 'Restangular'];

function run($rootScope, $state, Restangular) {
  $rootScope.go=$state.go;
  if($rootScope.user)
    $state.$go('user');

  Restangular.all('login').get('').then(success);

  function success(res) {
    if(res.success) {
        $rootScope.user = res.user;
        $state.go('user');
    }
  }
  $state.go('login');
}

export var run = run;
