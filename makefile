apt-get install curl
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
apt-get install -y nodejs
apt-get install mongodb
npm install -g coffee-script
npm install -g jade
npm install -g browserify
npm install -g uglify-js
mkdir ./server/data && mongod --dbpath ./server/data
