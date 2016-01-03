chai = require "chai"
sinon = require "sinon"
request = require "supertest"
api = require "./api"

chai.use require "sinon-chai"
chai.use require "chai-as-promised"

chai.config.includeStack = true

sinon.assert.expose chai.assert, prefix: ""

global.expect = chai.expect
global.sinon = sinon
global.api = api
global.request = request
