proxyquire = require "proxyquire"

describe "loginHandle", ->

  req = next = res = handle = userModel = send = query = undefined

  send = sinon.spy()

  next = sinon.spy()

  res = {}

  beforeEach ->

    send.reset()

    next.reset()

  describe "delete", ->

    error = new Error()

    before ->

      stub = sinon.stub()

      req = session: destroy: ->
        then: stub

      stub.onFirstCall().callsArg 0

      stub.onSecondCall().callsArgWith 1, error

      handle = proxyquire "./../loginHandle", "./../../lib/send": send

    it "sends if there is no error", ->

      handle.delete req, res, next

      expect(send).to.have.been.calledWithExactly res

      expect(next).to.have.not.been.called

    it "passes down error if there is error", ->

      handle.delete req, res, next

      expect(send).to.have.not.been.called

      expect(next).to.have.been.calledWithExactly error
