describe "sessionMiddleware", ->
    sessionMiddleware = sessionModel = requestIp = query = undefined
    middleware = req = res = next = ip = undefined

    beforeEach ->
        ip = "127.0.0.1"
        _id = "9348290490324"
        sessionModel =
            remove: sinon.stub()
            findOne: sinon.stub()
            create: sinon.stub()
        requestIp = getClientIp: sinon.stub()
        query = sinon.spy()
        req = {}
        res = {}
        next = sinon.spy()
        proxyquire = require "proxyquire"
        sessionMiddleware = sinon.spy proxyquire "./../sessionMiddleware",
            "./sessionModel": sessionModel
            "requestIp": requestIp
            "./../query": query
        middleware = sessionMiddleware()
        requestIp.getClientIp.returns ip

    it "should use \"user\" as default value", ->
        (expect middleware.remove).to.be.instanceOf Function
        (expect middleware.get).to.be.instanceOf Function
        (expect middleware.set).to.be.instanceOf Function
        (expect middleware.field).to.equal "user"

    describe "remove", ->
        _id = "9348290490324"
        beforeEach -> req.user = _id: _id

        it "should call query with res if removal was successful", (done) ->
            exec = new Promise (resolve, reject) -> resolve()
            sessionModel.remove.returns exec: -> exec
            middleware.remove req, res, next
            (expect sessionModel.remove).to.have.been.calledWithExactly _id: _id
            exec.then ->
                (expect next).not.to.have.been.called
                (expect query).to.have.been.calledWithExactly res
                done()

        it "should call next with Error if one occured while making DB query", (done) ->
            error = new Error
            exec = new Promise (resolve, reject) -> reject error
            sessionModel.remove.returns exec: -> exec
            middleware.remove req, res, next
            exec.then null, ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).not.to.have.been.called
                done()

    describe "set", ->
        it "should call next if no session field is avalible", ->
            middleware.set req, res, next
            (expect next).to.have.been.called
