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

    describe ".get", ->
        describe "[0]",->
            find = undefined

            beforeEach -> userModel.findById.returns exec: -> find

            it "assigns db result from finding user to req.send.user if req.user exists", (done) ->
                req.user = user: _id: "234324324"
                user = {}
                find = new Promise (resolve, reject) -> resolve user
                loginHandle.get[0] req, res, next
                (expect req.send).to.eql login: yes
                (expect userModel.findById).to.have.been.calledWithExactly "234324324"
                find.then (doc) ->
                    (expect req.send.user).to.eql user
                    (expect next).to.have.been.called
                    done()

            it "calls next with occured error if there was one", (done) ->
                req.user = user: _id: "234324324"
                error = new Error()
                find = new Promise (resolve, reject) -> reject error
                loginHandle.get[0] req, res, next
                find.then null, (err) ->
                    (expect next).to.have.been.calledWithExactly error
                    done()

            it "just calls next if req.user dosen't exist", ->
                loginHandle.get[0] req, res, next
                (expect userModel.findById).not.to.have.been.called
                (expect next).to.have.been.called

        describe "[1]", ->
            update = undefined

            beforeEach -> visitModel.update.returns exec: -> update

            it "properly sets visit for today and queries req.send (if req.userIP exists visit's ip get it's value)", (done) ->
                req.userIP = "127.0.0.1"
                req.send = login: yes
                visit =
                    date: "15/9/2012"
                    ip: "127.0.0.1"
                update = new Promise (resolve, reject) -> resolve()
                loginHandle.get[1] req, res, next
                (expect visitModel.update).to.have.been.calledWithExactly visit, user: yes, {upsert: yes}
                update.then ->
                    (expect query).to.have.been.calledWithExactly res, login: yes
                    (expect next).not.to.have.been.called
                    done()

            it "properly sets visit for today and queries req.send (if req.userIP dosen't exists visit's ip get req.user.ip's value)", (done) ->
                req.user = ip: "127.0.0.1"
                req.send = login: no
                visit =
                    date: "15/9/2012"
                    ip: "127.0.0.1"
                update = new Promise (resolve, reject) -> resolve()
                loginHandle.get[1] req, res, next
                (expect visitModel.update).to.have.been.calledWithExactly visit, user: no, {upsert: yes}
                update.then ->
                    (expect query).to.have.been.calledWithExactly res, login: no
                    (expect next).not.to.have.been.called
                    done()

            it "calls next with occured error if there was one", (done) ->
                req.user = ip: "127.0.0.1"
                req.send = login: no
                error = new Error()
                update = new Promise (resolve, reject) -> reject error
                loginHandle.get[1] req, res, next
                update.then null, (err) ->
                    (expect next).to.have.been.calledWithExactly error
                    (expect query).not.to.have.been.called
                    done()

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
