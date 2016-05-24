describe "descriptionHandle", ->
    descriptionHandle = descriptionModel = query = req = res = next = undefined

    beforeEach ->
        descriptionModel =
            findOne: sinon.stub()
            remove: sinon.stub()
        query = sinon.spy()
        req = params: order: "342424543514"
        res = {}
        next = sinon.spy()
        proxyquire = require "proxyquire"
        descriptionHandle = proxyquire "./../descriptionHandle",
            "./descriptionModel": descriptionModel
            "./../../../lib/query": query

    describe ".get", ->
        find = undefined

        beforeEach -> descriptionModel.findOne.returns exec: -> find

        it "gets null if none description exist for order with _id req.params.order", (done) ->
            description = null
            find = new Promise (resolve, reject) -> resolve description
            descriptionHandle.get req, res, next
            (expect descriptionModel.findOne).to.have.been.calledWithExactly order: req.params.order
            find.then (docs) ->
                (expect query).to.have.been.calledWithExactly res, description: description
                (expect next).to.have.not.been.calledWithExactly
                done()

        it "gets a description if one exist for order with _id req.params.order", (done) ->
            description =
                text: "test"
                order: "342424543514"
                _id: "34235345345"
            find = new Promise (resolve, reject) -> resolve description
            descriptionHandle.get req, res, next
            find.then (docs) ->
                (expect query).to.have.been.calledWithExactly res, description: description
                (expect next).to.have.not.been.calledWithExactly
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            find = new Promise (resolve, reject) -> reject error
            descriptionHandle.get req, res, next
            find.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".delete", ->
        remove = undefined

        beforeEach -> descriptionModel.remove.returns exec: -> remove

        it "deletes description with _id req.params.order", (done) ->
            remove = new Promise (resolve, reject) -> resolve()
            descriptionHandle.delete req, res, next
            (expect descriptionModel.remove).to.have.been.calledWithExactly _id: req.params.order
            remove.then (docs) ->
                (expect query).to.have.been.calledWithExactly res
                (expect next).to.have.not.been.calledWithExactly
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            remove = new Promise (resolve, reject) -> reject error
            descriptionHandle.delete req, res, next
            remove.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()
