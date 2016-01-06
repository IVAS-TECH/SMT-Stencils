describe "userHandle", ->

  handle = proxyquire = userModel = send = query = undefined

  before ->

    proxyquire = require "proxyquire"

    send = sinon.spy()

    query =
      basicHandle: sinon.spy()

  describe "get", ->

    req = res = next = stub = error = undefined

    before ->

      req = params: email: "test@test"

      res = {}

      next = sinon.spy()

      userModel =
        findOne: ->

      stub = sinon.stub userModel, "findOne"

      stub.onFirstCall().callsArgWith 1, null, not null

      stub.onSecondCall().callsArgWith 1, null, null

      error = new Error()

      stub.onThirdCall().callsArgWith 1, error, null

      handle = proxyquire "./../userHandle",
        "./userModel": userModel
        "./../../lib/send": send
        "./../../lib/query": query

    it "sends taken: true if email is registered", ->

      handle.get req, res, next

      expect(send).to.have.been
        .calledOnce
        .calledWithExactly res, taken: true

      expect(next).to.have.not.been.called

    it "sends taken: false if email isnt registered", ->

      handle.get req, res, next

      expect(send).to.have.been
        .calledTwice
        .calledWithExactly res, taken: false

      expect(next).to.have.not.been.called

    it "passes down error if db query failed", ->

      handle.get req, res, next

      expect(next).to.have.been.calledWithExactly error

      expect(send).to.have.not.been.calledTrice

  describe "post", ->

    req = res = stub = next = error = undefined

    before ->

      req = body: user:
        email: "test@test"
        password: "testtest"

      res = {}

      next = ->

      userModel = create: ->

      stub = sinon.stub userModel, "create"

      stub.onFirstCall().callsArgWith 1, null, not null

      error = new Error()

      stub.onSecondCall().callsArgWith 1, error, null

      handle = proxyquire "./../userHandle",
        "./userModel": userModel
        "./../../lib/query": query

    it "makes a call to query.basicHandle no metter if query status", ->

      handle.post req, res, next

      expect(query.basicHandle).to.have.been
        .calledOnce
        .calledWithExactly null, not null, res, next

      handle.post req, res, next

      expect(query.basicHandle).to.have.been
        .calledTwice
        .calledWithExactly error , null, res, next
