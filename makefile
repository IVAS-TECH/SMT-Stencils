all: clear setup #mongo

setup: install build

run:
	node ./server/app.js

install:
	bower install
	npm install

build: move clean dependencies

move:
	mkdir -p ./client/dependencies
	mv ./node_modules/babel-core/browser.js ./client/dependencies/browser.js
	mv ./node_modules/es6-module-loader/dist/es6-module-loader-dev.js  ./client/dependencies/es6-module-loader-dev.js
	mv ./bower_components/angular/angular.js ./client/dependencies/angular.js
	mv ./bower_components/angular-ui-router/release/angular-ui-router.js ./client/dependencies/angular-ui-router.js
	mv ./bower_components/ui-router-extras/release/ct-ui-router-extras.js ./client/dependencies/ct-ui-router-extras.js
	mv ./bower_components/angular-ui-router.stateHelper/statehelper.js ./client/dependencies/statehelper.js
	mv ./bower_components/angular-aria/angular-aria.js ./client/dependencies/angular-aria.js
	mv ./bower_components/angular-animate/angular-animate.js ./client/dependencies/angular-animate.js
	mv ./bower_components/angular-messages/angular-messages.js ./client/dependencies/angular-messages.js
	mv ./bower_components/angular-material/angular-material.js ./client/dependencies/angular-material.js
	mv ./bower_components/angular-material/angular-material.css ./client/dependencies/angular-material-css.css
	mv ./bower_components/restangular/dist/restangular.js ./client/dependencies/restangular.js
	mv ./bower_components/lodash/lodash.js ./client/dependencies/lodash.js
	mv ./bower_components/jquery/dist/jquery.js ./client/dependencies/jquery.js

dependencies:
	mv ./client/dependencies/browser.js browser.js
	node build.js >> dependencies.js
	rm ./client/dependencies/*.js
	mv browser.js ./client/dependencies/browser.js
	mv ./dependencies.js ./client/dependencies/dependencies.js

clear:
	rm -Rf ./bower_componentss
	rm -Rf ./node_modules
	rm -Rf ./client/dependencies

clean:
	rm -Rf ./bower_components
	rm -f ./dependencies.js

mongo:
	rm -Rf ./server/data
	mkdir ./server/data
	mongod --dbpath ./server/data
