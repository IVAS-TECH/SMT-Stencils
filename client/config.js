config.$inject = ['$stateProvider', '$mdThemingProvider'];

function config($stateProvider, $mdThemingProvider){
    $stateProvider
      .state('login', {
        templateUrl: 'view-login'
      })
      .state('user', {
        templateUrl: 'view-user'
      });

    $mdThemingProvider
      .theme('appTheme')
        .primaryPalette('teal')
        .accentPalette('indigo')
        .warnPalette('red')
        .backgroundPalette('blue-grey')
        .dark()
        .dark();
}

export var config = config;
