describe "loginHandle", ->
    loginHandle = userModel = query = visitModel = date = req = res = next = user = undefined

    beforeEach ->
        userModel =
            findById: sinon.stub()
            findOne: sinon.stub()
        query = sinon.spy()
        next = sinon.spy()
        visitModel = update: sinon.stub()
        date = format: sinon.stub()
        req = {}
        res = {}
        user =
            email: "test@test.com"
            language: "en"
            passwrod: "123456"

        proxyquire = require "proxyquire"
        loginHandle = proxyquire "./../loginHandle",
            "./userModel": userModel
            "./../../lib/query": query
            "./visit/visitModel": visitModel
            "./../../share/dateHelper": $get: -> date
        date.format.returns "15/9/2012"

    describe ".post", ->
        describe "[0]", ->
            found = undefined

            beforeEach ->
                req.body = user: user
                userModel.findOne.returns exec: -> found
                req.body.user = user

            it "should set req.user ifuser was found", (done) ->
                user = {}
                found = new Promise (resolve, reject) -> resolve user
                loginHandle.post[0] req, res, next
                (expect userModel.findOne).to.have.been.calledWithExactly req.body.user
                found.then (doc) ->
                    (expect req.user).to.eql user
                    (expect next).to.have.been.called
                    done()

            it "should call next with occured error if there was one", (done) ->
                error = new Error()
                found = new Promise (resolve, reject) -> reject error
                loginHandle.post[0] req, res, next
                found.then null, (err) ->
                    (expect req.user).to.be.undefined
                    (expect next).to.have.been.calledWithExactly error
                    done()

        describe "[2]", ->
            it "queries \n\t{\n\t\tlogin: true,\n\t\tuser:Object\n\t} if req.user exists", ->
                req.user = user: user
                loginHandle.post[2] req, res
                (expect query).to.have.been.calledWithExactly res, login: yes, user: user

            it "queries \n\t{\n\t\tlogin: true,\n\t\tuser: null (undefined)\n\t} if req.user doesn't exists", ->
                loginHandle.post[2] req, res
                (expect query).to.have.been.calledWithExactly res, login: no, user: undefined
