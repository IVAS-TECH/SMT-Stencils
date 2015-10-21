reqLogin.$inject = ['$location', '$cookies', '$rootScope'];

function reqLogin($location, $cookies, $rootScope) {
    var cookie = 'user',
      path = '/login',
      user = $cookies.get(cookie);

    if(!user)
      $location.path(path);
    else
      $rootScope.user = user;
}

export default reqLogin;
