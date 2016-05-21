describe "logErrorHandle", ->
    query = createWriteStream = query = next = handle = router = stream = log = handle = req = res = undefined

    beforeEach ->
        proxyquire = require "proxyquire"
        createWriteStream = sinon.stub()
        query = sinon.spy()
        next = sinon.spy()
        stream = write: sinon.stub()
        createWriteStream.returns stream
        log = "test.log"
        req = body: {}
        res = {}
        logErrorHandle = proxyquire "./../logErrorHandle",
            "./../lib/query": query
            "fs": createWriteStream: createWriteStream
        handle = logErrorHandle log

    it "logs error in stream and calls query", ->
        (expect createWriteStream).to.have.been.calledWithExactly log, flags: "a"
        stream.write.callsArgWith 2, null
        handle.post req, res, next
        (expect query).to.have.been.calledWithExactly res

    it "calls next with error if one occured", ->
        error = new Error()
        stream.write.callsArgWith 2, error
        handle.post req, res, next
        (expect next).to.have.been.calledWithExactly error
