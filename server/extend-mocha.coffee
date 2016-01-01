chai = require "chai"
sinon = require "sinon"
should = chai.should()

chai.use require "sinon-chai"
chai.use require "chai-as-promised"

chai.config.includeStack = true

sinon.assert.expose chai.assert, prefix: ""

global.expect = chai.expect
global.should = should
global.sinon = sinon
