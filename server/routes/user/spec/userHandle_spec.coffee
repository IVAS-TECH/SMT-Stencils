proxyquire = require "proxyquire"

describe "userHandle", ->

  handle = userModel = send = query = undefined

  res = {}

  send = sinon.spy()

  query =
    basicHandle: sinon.spy()

  beforeEach ->

    send.reset()

    query.basicHandle.reset()

  describe "get", ->

    req = next = stub = error = undefined

    before ->

      req = params: email: "test@test"

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
        .calledWithExactly res, taken: true

      expect(next).to.have.not.been.called

    it "sends taken: false if email isnt registered", ->

      handle.get req, res, next

      expect(send).to.have.been
        .calledWithExactly res, taken: false

      expect(next).to.have.not.been.called

    it "passes down error if db query failed", ->

      handle.get req, res, next

      expect(next).to.have.been.calledWithExactly error

      expect(send).to.have.not.been.called

  describe "post", ->

    req = stub = next = error = undefined

    before ->

      req = body: user:
        email: "test@test"
        password: "testtest"

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

  describe "patch", ->

    req = res = stub = next = error = undefined

    before ->

      next = ->

      userModel = findByIdAndUpdate: ->

      stub = sinon.stub userModel, "findByIdAndUpdate"

      stub.onFirstCall().callsArgWith 3, null, not null

      stub.onSecondCall().callsArgWith 3, null, not null

      error = new Error()

      stub.onThirdCall().callsArgWith 3, error, null

      handle = proxyquire "./../userHandle",
        "./userModel": userModel
        "./../../lib/query": query

    beforeEach -> req = session: get: uid: "id"

    it "calls userModel.findByIdAndUpdate with user id and {emial: value} and makes a call to query.basicHandle", ->

      req.body =
        type: "email"
        value: "email@email"

      handle.patch req, res, next

      expect(stub).to.have.been
        .calledWith req.session.get.uid, $set: email: "email@email", {new: true}

      expect(query.basicHandle).to.have.been
        .calledWithExactly null, not null, res, next

    it "calls userModel.findByIdAndUpdate with user id and {password: value} and makes a call to query.basicHandle", ->

      req.body =
        type: "password"
        value: "password"

      handle.patch req, res, next

      expect(stub).to.have.been
        .calledWith req.session.get.uid, $set: password: "password", {new: true}

      expect(query.basicHandle).to.have.been
        .calledWithExactly null, not null, res, next

    it "passes on error", ->

      req.body =
        type: "notExpected"
        value: "error"

      handle.patch req, res, next

      expect(query.basicHandle).to.have.been
        .calledWithExactly error, null, res, next
