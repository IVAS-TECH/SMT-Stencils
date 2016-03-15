describe "basicCRUDHandle", ->

  proxyquire = require "proxyquire"

  req = basicHandle = send = next = handle = modelStub = undefined

  model =
    create: ->
    find: ->
    findByIdAndUpdate: ->
    remove: ->

  res = {}

  error = new Error()

  before ->

    modelStub = sinon.stub model

    send = sinon.spy()

    next = sinon.spy()

    basicHandle = sinon.spy()

    tested = proxyquire "./../basicCRUDHandle",
      "./../../lib/send": send
      "./../../lib/query": basicHandle: basicHandle

    handle = tested modelStub, "test"

  beforeEach ->

    send.reset()

    next.reset()

    basicHandle.reset()

  describe "get", ->

    docs = [not null, not null, not null]

    before ->

      req = session: get: uid: "id"

      modelStub.find.onFirstCall().callsArgWith 1, null, docs

      modelStub.find.onSecondCall().callsArgWith 1, error, null

    it "should send tests: $Array if there is no error", ->

      handle.get req, res, next

      expect(send).to.have.been.calledWithExactly res, testList: docs

      expect(next).not.to.have.been.called

    it "should passdown error if there is one", ->

      handle.get req, res, next

      expect(send).not.to.have.been.called

      expect(next).to.have.been.calledWithExactly error

  run = (method, mock, index) ->

    describe method, ->

      doc = not null

      before ->

        req =
          session: get: uid: "id"
          body: test: doc

        modelStub[mock].onFirstCall().callsArgWith index, null, doc

        modelStub[mock].onSecondCall().callsArgWith index, error, null

      it "should call query.basicHandle with successful result", ->

        handle[method] req, res, next

        expect(basicHandle).to.have.been.calledWithExactly null, doc, res, next

      it "should call query.basicHandle with erroring result", ->

        handle[method] req, res, next

        expect(basicHandle).to.have.been.calledWithExactly error, null, res, next

  run "post", "create", 1

  run "patch", "findByIdAndUpdate", 3

  describe "delete", ->

    before ->

      req = params: id: "id"

      modelStub.remove.onFirstCall().callsArgWith 1, null

      modelStub.remove.onSecondCall().callsArgWith 1, error

    it "should send if there is no error", ->

      handle.delete req, res, next

      expect(send).to.have.been.calledWithExactly res

      expect(next).not.to.have.been.called

    it "should passdown error if there is one", ->

      handle.delete req, res, next

      expect(send).not.to.have.been.called

      expect(next).to.have.been.calledWithExactly error
