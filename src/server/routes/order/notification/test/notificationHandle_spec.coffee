describe "notificationHandle", ->
    notificationHandle = notificationModel = query = req = res = next = undefined

    beforeEach ->
        notificationModel =
            find: sinon.stub()
            remove: sinon.stub()
        query = sinon.spy()
        req = {}
        res = {}
        next = sinon.spy()
        proxyquire = require "proxyquire"
        notificationHandle = proxyquire "./../notificationHandle",
            "./notificationModel": notificationModel
            "./../../../lib/query": query

    describe ".get", ->
        find = undefined

        beforeEach ->
            notificationModel.find.returns exec: -> find
            req.user = user: _id: "342424543514"

        it "gets all notifications for user with _id req.user.user._id", (done) ->
            notifications = []
            find = new Promise (resolve, reject) -> resolve notifications
            notificationHandle.get req, res, next
            (expect notificationModel.find).to.have.been.calledWithExactly user: req.user.user._id
            find.then (docs) ->
                (expect query).to.have.been.calledWithExactly res, notifications: notifications
                (expect next).to.have.not.been.calledWithExactly
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            find = new Promise (resolve, reject) -> reject error
            notificationHandle.get req, res, next
            find.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()

    describe ".delete", ->
        remove = undefined

        beforeEach ->
            notificationModel.remove.returns exec: -> remove
            req.params = id: "342424543514"

        it "deletes notification with _id req.params.id", (done) ->
            remove = new Promise (resolve, reject) -> resolve()
            notificationHandle.delete req, res, next
            (expect notificationModel.remove).to.have.been.calledWithExactly _id: req.params.id
            remove.then (docs) ->
                (expect query).to.have.been.calledWithExactly res
                (expect next).to.have.not.been.calledWithExactly
                done()

        it "calls next with occured error, if there was one", (done) ->
            error = new Error()
            remove = new Promise (resolve, reject) -> reject error
            notificationHandle.delete req, res, next
            remove.then null, (err) ->
                (expect next).to.have.been.calledWithExactly error
                (expect query).to.have.not.been.called
                done()
