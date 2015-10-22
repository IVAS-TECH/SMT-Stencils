reqLogin.$inject = ['$location', 'Restangular', '$rootScope'];

function reqLogin($location, Restangular, $rootScope) {
    Restangular.all('login').get('').then(success);

    function success(res) {
      var path = '/login';
      if(res.secret === '')
        $location.path(path);
      else
        $rootScope.secret = res.secret;
    }
}

export default reqLogin;
