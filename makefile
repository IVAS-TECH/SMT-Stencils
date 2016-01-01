setup:
	sudo apt-get install -y curl
	curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
	sudo apt-get install -y nodejs
	sudo apt-get install -y mongodb
	sudo apt-get install gerbv

globals:
	sudo npm install -g coffee-script
	sudo npm install -g jade
	sudo npm install -g browserify
	sudo npm install -g uglify-js
	sudo npm install -g karma-cli
	sudo npm install -g mocha
