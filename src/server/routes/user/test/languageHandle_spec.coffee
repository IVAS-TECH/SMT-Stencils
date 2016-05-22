describe "languageHandle", ->
    languageHandle = userModel = query = req = res = next = found = undefined

    beforeEach ->
        userModel = findById: sinon.stub()
        query = sinon.spy()
        next = sinon.spy()
        req = params: user: "42342534534"
        res = {}
        proxyquire = require "proxyquire"
        languageHandle = proxyquire "./../languageHandle",
            "./userModel": userModel
            "./../../lib/query": query
        userModel.findById.returns exec: -> found

    it "queries user language", (done) ->
        user =
            email: "test@test.com"
            language: "en"
            password: "123456"
            admin: 0
        found = new Promise (resolve, reject) -> resolve user
        languageHandle.get req, res, next
        (expect userModel.findById).to.have.been.calledWithExactly req.params.user
        found.then (doc) ->
            (expect query).to.have.been.calledWithExactly res, language: user
            (expect next).to.have.not.been.called
            done()

    it "calls next with occured error, if there was one", (done) ->
        error = new Error()
        found = new Promise (resolve, reject) -> reject error
        languageHandle.get req, res, next
        found.then null, (doc) ->
            (expect query).not.to.have.been.called
            (expect next).to.have.been.calledWithExactly error
            done()
