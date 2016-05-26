FROM ubuntu:16.04
FROM node:latest

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y libcairo2-dev
RUN apt-get install -y gerbv

RUN mkdir -p /tmp/app
ADD package.json /tmp/app/package.json
ADD gulpfile.* /tmp/app/
ADD server /tmp/app/server/
ADD client /tmp/app/client/
RUN cd /tmp/app && npm install;npm run build
RUN mkdir -p /opt/app
RUN cp /tmp/app/package.json /opt/app/package.json
RUN cp -ar /tmp/app/node_modules /opt/app/
RUN cp -ar /tmp/app/deploy /opt/app/

WORKDIR /opt/app
ADD . /opt/app

ENTRYPOINT ["npm", "start"]
EXPOSE 8080
