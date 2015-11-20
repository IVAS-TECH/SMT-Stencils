run.$inject = ['$rootScope', '$state', 'Restangular'];

function run($rootScope, $state, Restangular) {
  if($rootScope.user)
    $state.go('home');

  Restangular
    .oneUrl('login')
    .get()
    .then(success);

  function success(res) {
    if(res.success)
      $rootScope.user = res.user;
  }

  $state.go('home');
}

export var run = run;
