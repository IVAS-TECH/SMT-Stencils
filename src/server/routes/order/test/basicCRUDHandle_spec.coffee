describe "basicCRUDHandle", ->
    handle = query = model = req = res = next = undefined

    beforeEach ->
        query = sinon.spy()
        next = sinon.spy()
        req = user: user: _id: "342923173924"
        res = {}
        model =
            find: sinon.stub()
            create: sinon.stub()
            findByIdAndUpdate: sinon.stub()
            findOne: sinon.stub()
            remove: sinon.stub()
        proxyquire = require "proxyquire"
        basicCRUDHandle = proxyquire "./../basicCRUDHandle", "./../../lib/query": query
        handle = basicCRUDHandle model, "test"

    describe ".get", ->
        find = undefined

        beforeEach -> model.find.returns exec: -> find

        it "gets all documents for user with _id req.user.user._id", (done) ->
            documents = []
            find = new Promise (resolve, reject) -> resolve documents
            handle.get req, res, next
            (expect model.find).to.have.been.calledWithExactly user: req.user.user._id
            find.then (docs) ->
                (expect query).to.have.been.calledWithExactly res, testList: documents
                (expect next).to.have.not.been.called
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            find = new Promise (resolve, reject) -> reject error
            handle.get req, res, next
            find.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".post", ->
        beforeEach -> req.body = test: {}

        it "creates new document", (done) ->
            created = _id: "394234274137"
            create = new Promise (resolve, reject) -> resolve created
            model.create.returns create
            handle.post req, res, next
            (expect req.body.test.user).to.equal req.user.user._id
            (expect model.create).to.have.been.calledWithExactly req.body.test
            create.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, created
                (expect next).to.have.not.been.called
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            create = new Promise (resolve, reject) -> reject error
            model.create.returns create
            handle.post req, res, next
            create.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".patch", ->
        id = update = undefined

        beforeEach ->
            id = "34252534545534"
            req.body = test: _id: id
            model.findByIdAndUpdate.returns exec: -> update

        it "updates document by id", (done) ->
            updated = _id: id
            update = new Promise (resolve, reject) -> resolve updated
            handle.patch req, res, next
            (expect req.body.test._id).to.be.undefined
            (expect model.findByIdAndUpdate).to.have.been.calledWithExactly id, $set: {}, {new: yes}
            update.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, updated
                (expect next).to.have.not.been.called
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            update = new Promise (resolve, reject) -> reject error
            handle.patch req, res, next
            update.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".put", ->
        find = undefined

        beforeEach ->
            req.body = taken: "test"
            model.findOne.returns exec: -> find

        it "queries taken: false if none document was found", (done) ->
            find = new Promise (resolve, reject) -> resolve null
            handle.put req, res, next
            (expect model.findOne).to.have.been.calledWithExactly
                user: req.user.user._id
                name: req.body.taken
            find.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, taken: no
                (expect next).to.have.not.been.called
                done()

        it "queries taken: true if a document was found", (done) ->
            find = new Promise (resolve, reject) -> resolve {}
            handle.put req, res, next
            find.then (doc) ->
                (expect query).to.have.been.calledWithExactly res, taken: yes
                (expect next).to.have.not.been.called
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            find = new Promise (resolve, reject) -> reject error
            handle.put req, res, next
            find.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".delete", ->
        remove = undefined

        beforeEach ->
            req.params = id: "3432423445"
            model.remove.returns exec: -> remove

        it "deletes description with _id req.params.order", (done) ->
            remove = new Promise (resolve, reject) -> resolve()
            handle.delete req, res, next
            (expect model.remove).to.have.been.calledWithExactly _id: req.params.id
            remove.then (docs) ->
                (expect query).to.have.been.calledWithExactly res
                (expect next).to.have.not.been.calledWithExactly
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            remove = new Promise (resolve, reject) -> reject error
            handle.delete req, res, next
            remove.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()
