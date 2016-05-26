FROM ubuntu:16.04
FROM node:latest

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y libcairo2-dev
RUN apt-get install -y gerbv

RUN npm install
RUN npm run build

WORKDIR .

ENTRYPOINT ["npm", "start"]
EXPOSE 8080
