reqLogin.$inject = ['$location', '$cookies', '$rootScope'];

function reqLogin($location, $cookies, $rootScope) {
    var user = $cookies.get('user');
    if(!user) {
      $location.path('/login');
    } else {
      $rootScope.user = user;
    }
}

export default reqLogin;
