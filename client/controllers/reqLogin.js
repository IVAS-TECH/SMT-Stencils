reqLogin.$inject = ['$location', 'Restangular', '$rootScope'];

function reqLogin($location, Restangular, $rootScope) {
    if($rootScope.user)
      return;

    Restangular.all('login').get('').then(success);

    function success(res) {
      var path = '/login';
      if(res.success)
        $rootScope.user = res.user;
      else
        $location.path(path);

    }
}

export default reqLogin;
