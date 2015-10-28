all: clear unset setup mongo

setup: install build

run:
	node ./server/app.js

install:
	bower install
	npm install

build: move clean

move:
	cp ./node_modules/babel-core/browser.js ./client/dependencies/browser.js
	cp ./node_modules/es6-module-loader/dist/es6-module-loader-dev.js  ./client/dependencies/es6-module-loader-dev.js
	cp ./bower_components/angular/angular.js ./client/dependencies/angular.js
	cp ./bower_components/angular-ui-router/release/angular-ui-router.js ./client/dependencies/angular-ui-router.js
	cp ./bower_components/ui-router-extras/release/ct-ui-router-extras.js ./client/dependencies/ct-ui-router-extras.js
	cp ./bower_components/angular-ui-router.stateHelper/statehelper.js ./client/dependencies/statehelper.js
	cp ./bower_components/angular-aria/angular-aria.js ./client/dependencies/angular-aria.js
	cp ./bower_components/angular-animate/angular-animate.js ./client/dependencies/angular-animate.js
	cp ./bower_components/angular-messages/angular-messages.js ./client/dependencies/angular-messages.js
	cp ./bower_components/angular-material/angular-material.js ./client/dependencies/angular-material.js
	cp ./bower_components/angular-material/angular-material.css ./client/dependencies/angular-material-css.css
	cp ./bower_components/restangular/dist/restangular.js ./client/dependencies/restangular.js
	cp ./bower_components/lodash/lodash.js ./client/dependencies/lodash.js
	cp ./bower_components/jquery/dist/jquery.js ./client/dependencies/jquery.js

unset:
	rm -Rf ./client/dependencies
	mkdir -p ./client/dependencies

clear:
	rm -Rf ./bower_componentss
	rm -Rf ./node_modules

clean:
	rm -Rf ./bower_components

mongo:
	rm -Rf ./server/data
	mkdir ./server/data
	mongod --dbpath ./server/data
