describe "sessionMiddleware", ->
    sessionMiddleware = sessionModel = getClientIP = query = undefined
    middleware = req = res = next = ip = _id = undefined

    beforeEach ->
        ip = "127.0.0.1"
        _id = "9348290490324"
        sessionModel =
            remove: sinon.stub()
            findOne: sinon.stub()
            create: sinon.stub()
        getClientIP = sinon.stub()
        query = sinon.spy()
        req = {}
        res = {}
        next = sinon.spy()
        proxyquire = require "proxyquire"
        sessionMiddleware = sinon.spy proxyquire "./../sessionMiddleware",
            "./sessionModel": sessionModel
            "./getClientIP": getClientIP
            "./../query": query
        middleware = sessionMiddleware()
        getClientIP.returns ip

    it "should use \"user\" as default value", ->
        (expect middleware.remove).to.be.instanceOf Function
        (expect middleware.get).to.be.instanceOf Function
        (expect middleware.set).to.be.instanceOf Function
        (expect middleware.field).to.equal "user"

    describe "remove", ->
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

    describe "get", ->
        it "appends request ip to the request object if none user was found", (done) ->
            find = new Promise (resolve, reject) -> resolve null
            sessionModel.findOne.returns populate: (field) -> exec: -> find
            middleware.get req, res, next
            (expect sessionModel.findOne).to.have.been.calledWithExactly ip: ip
            find.then (doc) ->
                (expect req.user).to.eql null
                (expect req.userIP).to.equal ip
                (expect next).to.have.been.called
                done()

        it "shouldn't append request ip to request object if the retrived doc exist because it will contain it", (done) ->
            user = _id: _id, ip: ip
            find = new Promise (resolve, reject) -> resolve user
            sessionModel.findOne.returns populate: (field) -> exec: -> find
            middleware.get req, res, next
            find.then (doc) ->
                (expect req.user).to.eql user
                (expect req.userIP).to.be.undefined
                (expect next).to.have.been.called
                done()

        it "should call next with the occured Error", (done) ->
            error = new Error
            find = new Promise (resolve, reject) -> reject error
            sessionModel.findOne.returns populate: (field) -> exec: -> find
            middleware.get req, res, next
            find.then null, (err) ->
                (expect err).to.eql error
                (expect next).to.have.been.calledWithExactly error
                done()

    describe "set", ->
        it "should call next if no session field is avalible (no user info on request object)", ->
            middleware.set req, res, next
            (expect next).to.have.been.called

        it "should create new session if there is user info on request object", (done) ->
            req.user = _id: _id
            id = "3845628748923"
            create = new Promise (resolve, reject) -> resolve _id: id
            sessionModel.create.returns create
            middleware.set req, res, next
            (expect sessionModel.create).to.have.been.calledWithExactly
                user: _id
                ip: ip
            create.then (doc) ->
                (expect req.user).to.eql
                    user: _id: _id
                    ip: ip
                    _id: id
                (expect next).to.have.been.called
                done()

        it "should call next with the occured Error", (done) ->
            req.user = {}
            error = new Error
            create = new Promise (resolve, reject) -> reject error
            sessionModel.create.returns create
            middleware.set req, res, next
            (expect sessionModel.create).to.have.been.calledWithExactly
                user: undefined
                ip: ip
            create.then null, (err) ->
                (expect err).to.eql error
                (expect next).to.have.been.calledWithExactly error
                done()
