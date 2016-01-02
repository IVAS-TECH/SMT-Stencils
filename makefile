setup:
	sudo apt-get install -y curl
	curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
	sudo apt-get install -y nodejs
	sudo apt-get install -y mongodb
	sudo apt-get install gerbv

task:
	sed 's/\.\.\/lib/\.\/node_modules\/coffee\-script\/lib/' < ./node_modules/coffee-script/bin/cake > ./task
	chmod 777 ./task
