config.$inject = ['stateHelperProvider', '$mdThemingProvider'];

function config(stateHelperProvider, $mdThemingProvider) {
    configStates(stateHelperProvider);
    configTheme($mdThemingProvider);
}

function configStates(stateHelperProvider) {
  var loginHomeState = {},
    userHomeState = {},
    aboutState = {},
    techState = {},
    contactState = {},
    loginState = {},
    userState = {},
    common = [aboutState, techState, contactState],
    loginChild = [],
    userChild = [];

  loginHomeState.name = 'home';
  loginHomeState.template = ' Login Home';
  userHomeState.name = 'home';
  userHomeState.template = 'User Home';
  aboutState.name = 'about';
  aboutState.template = "About";
  techState.name = 'tech';
  techState.template = "Tech";
  contactState.name = 'contact';
  contactState.template = "Contact";

  loginChild = angular.copy(common);
  loginChild.push(loginHomeState);
  loginState.name = 'login';
  loginState.templateUrl = 'view-login';
  loginState.deepStateRedirect = true;
  loginState.children = loginChild;

  userChild = angular.copy(common);
  userChild.push(userHomeState);
  userState.name = 'user';
  userState.templateUrl = 'view-user';
  userState.deepStateRedirect = true;
  userState.children = userChild;

  stateHelperProvider
    .state(loginState)
    .state(userState);
}

function configTheme($mdThemingProvider) {
  $mdThemingProvider
    .theme('default')
      .primaryPalette('teal')
      .accentPalette('indigo')
      .warnPalette('red')
      .backgroundPalette('blue-grey')
      .dark()
      .dark();
}

export var config = config;
