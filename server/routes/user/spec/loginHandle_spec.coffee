describe "loginHandle", ->

  req = next = res = handle = proxyquire = userModel = send = query = undefined

  before ->

    proxyquire = require "proxyquire"

    send = sinon.spy()

    next = sinon.spy()

    res = {}

  describe "delete", ->

    error = new Error()

    before ->

      send.reset()
      next.reset()

      stub = sinon.stub()

      req = session: destroy: ->
        then: stub

      stub.onFirstCall().callsArg 0

      stub.onSecondCall().callsArgWith 1, error

      handle = proxyquire "./../loginHandle", "./../../lib/send": send

    it "sends if there is no error", ->

      handle.delete req, res, next

      expect(send).to.have.been
        .calledOnce
        .and.calledWithExactly res

      expect(next).to.have.not.been.called

    it "passes down error if there is one", ->

      handle.delete req, res, next

      expect(send).to.have.been.calledOnce

      expect(next).to.have.been
        .calledOnce
        .and.calledWithExactly error
