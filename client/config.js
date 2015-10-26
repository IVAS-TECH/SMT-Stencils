config.$inject = ['stateHelperProvider', '$mdThemingProvider'];

function config(stateHelperProvider, $mdThemingProvider) {
    configStates(stateHelperProvider);
    configTheme($mdThemingProvider);
}

function configStates(stateHelperProvider) {
  var loginState = {},
    loginHomeState = {},
    loginAboutState = {},
    loginTechState = {},
    loginContactState = {},
    userState = {};

  loginState.name = 'login';
  loginState.templateUrl = 'view-login';
  loginState.deepStateRedirect = true;
  loginState.children = [loginHomeState, loginAboutState, loginTechState, loginContactState];
  loginHomeState.name = 'home';
  loginHomeState.template = 'Home';
  loginAboutState.name = 'about';
  loginAboutState.template = "About";
  loginTechState.name = 'tech';
  loginTechState.template = "Tech";
  loginContactState.name = 'contact';
  loginContactState.template = "Contact";

  userState.name = 'user';
  userState.templateUrl = 'view-user';

  stateHelperProvider
    .state(loginState)
    .state(userState);
}

function configTheme($mdThemingProvider) {
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
