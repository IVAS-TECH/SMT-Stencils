var fs = require('fs');
var dependencies = [
  "jquery",
  "lodash",
  "angular",
  "angular-ui-router",
  "ct-ui-router-extras",
  "statehelper",
  "angular-aria",
  "angular-animate",
  "angular-messages",
  "angular-material",
  "restangular",
  "es6-module-loader-dev"
];

for(var i = 0;i < dependencies.length; ++i) {
  var file = __dirname + "/client/dependencies/" + dependencies[i] + '.js';
    console.log(fs.readFileSync(file, 'utf8'));
}
