chai = require "chai"
sinon = require "sinon"
request = require "supertest"
coverage = require "coffee-coverage"

chai.use require "sinon-chai"
chai.config.includeStack = true

sinon.assert.expose chai.assert, prefix: ""

global.expect = chai.expect
global.sinon = sinon
global.request = request

coverage.register
    instrumentor: "istanbul"
    writeOnExit: "./coverage/coverage-coffee.json"
    initAll: yes
