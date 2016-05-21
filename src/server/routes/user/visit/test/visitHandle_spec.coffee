describe "visitHandle", ->
    visitModel = query = next = req = res = visitHandle = sort = found = undefined

    beforeEach ->
        query = sinon.spy()
        next = sinon.spy()
        sort = sinon.stub()
        visitModel = find: sinon.stub()
        proxyquire = require "proxyquire"
        visitHandle = proxyquire "./../visitHandle",
            "./visitModel": visitModel
            "./../../../lib/query": query
        req = {}
        res = {}
        visitModel.find.returns sort: sort
        sort.returns exec: -> found

    it "should call query with res and {visit: docs}", (done) ->
        docs = []
        docs[0] =
            ip: "127.0.0.1"
            user: _id: "01432432231"
            date: new Date 2014, 8, 15
        docs[1] =
            ip: "127.0.0.1"
            user: _id: "01432432231"
            date: new Date 2014, 6, 3
        found = new Promise (resolve, reject) -> resolve docs
        visitHandle.get req, res, next
        found.then (docs) ->
            (expect query).to.have.been.calledWithExactly res, visits: docs
            (expect next).not.to.have.been.called
            done()

    it "should call next with occured error", (done) ->
        error = new Error()
        found = new Promise (resolve, reject) -> reject error
        visitHandle.get req, res, next
        found.then null, (err) ->
            (expect query).not.to.have.been.called
            (expect next).to.have.been.calledWithExactly error
            done()
