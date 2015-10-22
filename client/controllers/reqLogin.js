reqLogin.$inject = ['$location', 'Restangular', '$rootScope'];

function reqLogin($location, Restangular, $rootScope) {
    Restangular.all('login').get('').then(success);

    function success(res) {
      var path = '/login';
      console.log(res);
      if(res.secret === '')
        $location.path(path);
      else {
        $rootScope.secret = res.secret;
        console.log($rootScope.secret);
      }
    }
}

export default reqLogin;
