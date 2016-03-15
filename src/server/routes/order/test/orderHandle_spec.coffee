describe "orderHandle", ->

  proxyquire = require "proxyquire"

  req = basicHandle = send = next = orderHandle = orderModel = isAdmin = GerberToSVG = undefined

  model =
    create: ->
    find: ->

  res = {}

  error = new Error()

  before ->

    orderModel = sinon.stub model

    send = sinon.spy()

    next = sinon.spy()

    basicHandle = sinon.spy()

    isAdmin = sinon.stub()

    GerberToSVG = sinon.stub()

    orderHandle = proxyquire "./../orderHandle",
      "./orderModel": orderModel
      "./../user/admin/isAdmin": isAdmin
      "./../../lib/GerberToSVG": GerberToSVG
      "./../../lib/send": send
      "./../../lib/query": basicHandle: basicHandle

  beforeEach ->

    send.reset()

    next.reset()

    basicHandle.reset()

  describe "post and get", ->

    id = "id"

    order = {}

    describe "post", ->

      before ->

        req =
          session: get: uid: id
          body: order: order

        orderModel.create.onFirstCall().callsArgWith 1, null, order

        orderModel.create.onSecondCall().callsArgWith 1, error, null

      it "should create new order and make a proper call to basicHandle", ->

        orderHandle.post req, res, next

        expect(basicHandle).to.have.been.calledWithExactly null, order, res, next

      it "should fail and call basicHandle with error result", ->

        orderHandle.post req, res, next

        expect(basicHandle).to.have.been.calledWithExactly error , null, res, next

    describe "get", ->

      docs = [not null, not null, not null]

      before ->

        orderModel.find.onFirstCall().callsArgWith 1, null, [not null]

        orderModel.find.onSecondCall().callsArgWith 1, null, docs

        orderModel.find.onThirdCall().callsArgWith 1, error, null

        isAdmin.onFirstCall().returns
          then: (resolve, reject) ->
            reject error

        isAdmin.onSecondCall().returns
          then: (resolve, reject) ->
            resolve admin: no

        isAdmin.returns
          then: (resolve, reject) ->
            resolve admin: yes

      it "should pass down error if isAdmin rejected", ->

        orderHandle.get req, res, next

        expect(next).to.have.been.calledWithExactly error

        expect(orderModel.find).not.to.have.been.called

      it "should send orders owned by user only", ->

        orderHandle.get req, res, next

        expect(orderModel.find).to.have.been.calledWithExactly user: id, sinon.match.func

        expect(send).to.have.been.calledWithExactly res, orders: [not null]

        expect(next).not.to.have.been.called

      it "should send all orders if user is admin", ->

        orderHandle.get req, res, next

        expect(orderModel.find).to.have.been.calledWithExactly {}, sinon.match.func

        expect(send).to.have.been.calledWithExactly res, orders: docs

        expect(next).not.to.have.been.called

      it "should pass down error if query failed", ->

        orderHandle.get req, res, next

        expect(next).to.have.been.calledWithExactly error

        expect(send).not.to.have.been.called

  describe "put", ->

    files = ["top.gbr", "bottom.gbr", "out.gbr"]

    svg = {}

    before ->

      req = body: files: files

      GerberToSVG.returns
        then: (resolve, reject) ->
          resolve svg

    it "should send the result of calling GerberToSVG with resolving provided files", ->

      orderHandle.put req, res, next

      expect(send).to.have.been.calledWithExactly res, svg

      args = GerberToSVG.args[0]

      test = (index) ->
        expect(args[index]).to.match new RegExp "/files/#{files[index]}"

      test i for i of args
