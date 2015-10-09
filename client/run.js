import { url }  from '/config.js';

run.$inject = ['$location'];

function run ($location) {
  var l = location.pathname;
  l = url.indexOf(l) > -1 ? l : '/app';
  $location.path(l);
}

export var run = run;
