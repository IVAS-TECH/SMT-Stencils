describe "userHandle", ->
    userHandle = fs = join = userModel = query = models = req = res = next = undefined

    beforeEach ->
        userModel =
            find: sinon.stub()
            create: sinon.stub()
            findByIdAndUpdate: sinon.stub()
            findOne: sinon.stub()
        query = sinon.spy()
        next = sinon.spy()
        req = {}
        res = {}
        proxyquire = require "proxyquire"
        userHandle = proxyquire "./../userHandle",
            "./userModel": userModel
            "./../../lib/query": query

    describe ".get", ->
        find = undefined

        beforeEach -> userModel.find.returns sort: -> exec: -> find

        it "gets all users", (done) ->
            users = [
                {
                    email: "test@test.com"
                    password: "123456"
                    language: "en"
                    admin: 2
                }
                {
                    email: "test2@test.com"
                    password: "123456"
                    language: "bg"
                    admin: 0
                }
            ]
            find = new Promise (resolve, reject) -> resolve users
            userHandle.get req, res, next
            (expect userModel.find).to.have.been.calledWithExactly {}
            find.then (docs) ->
                (expect query).to.have.been.calledWithExactly res, users: users
                (expect next).to.have.not.been.called
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            find = new Promise (resolve, reject) -> reject error
            userHandle.get req, res, next
            find.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".post", ->
        user = undefined

        beforeEach ->
            user =
                email: "test@test.com"
                password: "123456"
                language: "en"
                admin: 2
            req.body = user: user

        it "creates new User", (done) ->
            create = new Promise (resolve, reject) -> resolve user
            userModel.create.returns create
            userHandle.post req, res, next
            (expect userModel.create).to.have.been.calledWithExactly req.body.user
            create.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, user
                (expect next).to.have.not.been.called
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            create = new Promise (resolve, reject) -> reject error
            userModel.create.returns create
            userHandle.post req, res, next
            create.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".patch", ->
        update = user = undefined

        beforeEach ->
            req.user = user: _id: "23020324"
            user =
                email: "test@test.com"
                password: "123456"
                language: "en"
                admin: 2
            req.body = user: user
            userModel.findByIdAndUpdate.returns exec: -> update

        it "finds and updates user by using req.user.user._id if req.body.id is \"id\"", (done) ->
            update = new Promise (resolve, reject) -> resolve user
            req.body.id = "id"
            userHandle.patch req, res, next
            (expect userModel.findByIdAndUpdate).to.have.been.calledWithExactly req.user.user._id, $set: req.body.user, {new: yes}
            update.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, user
                (expect next).to.have.not.been.called
                done()

        it "finds and updates user by using req.body.id if req.body.id isn't \"id\"", (done) ->
            update = new Promise (resolve, reject) -> resolve user
            req.body.id = "394239435"
            userHandle.patch req, res, next
            (expect userModel.findByIdAndUpdate).to.have.been.calledWithExactly req.body.id, $set: req.body.user, {new: yes}
            update.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, user
                (expect next).to.have.not.been.called
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            update = new Promise (resolve, reject) -> reject error
            req.body.id = "id"
            userHandle.patch req, res, next
            update.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".put", ->
        find = undefined

        beforeEach ->
            req.body = taken: "test@test.com"
            userModel.findOne. returns exec: -> find

        it "queries {taken: true} if email exixts", (done) ->
            user = {}
            find = new Promise (resolve, reject) -> resolve user
            userHandle.put req, res, next
            (expect userModel.findOne).to.have.been.calledWithExactly email: req.body.taken
            find.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, taken: yes
                (expect next).to.have.not.been.called
                done()

        it "queries {taken: false} if email dosen't exixts", (done) ->
            find = new Promise (resolve, reject) -> resolve null
            userHandle.put req, res, next
            find.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, taken: no
                (expect next).to.have.not.been.called
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            find = new Promise (resolve, reject) -> reject error
            userHandle.put req, res, next
            find.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".delete", ->
        it "need's to be written at some point"
