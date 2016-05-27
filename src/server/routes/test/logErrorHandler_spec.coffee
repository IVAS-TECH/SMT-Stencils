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
        req.body =
            error: "Error"
            at: "http://localhost:8080:30:29"
            desc: "value: [null] ,"
        handle.post req, res, next
        result = "(error=Error at=http://localhost:8080:30:29 desc=value: [null] ,)\n"
        (expect stream.write).to.have.been.calledWithExactly result, "utf-8", sinon.match.func
        (expect query).to.have.been.calledWithExactly res

    it "calls next with error if one occured", ->
        error = new Error()
        stream.write.callsArgWith 2, error
        req.body = test:
            error: "Error"
            desc: {}
            at: []
            extra: [1, 2]
            n: [null]
            u: undefined
        handle.post req, res, next
        result = "(test=(error=Error desc=() at=() extra=(0=1 1=2) n=(0=null) u=undefined))\n"
        (expect stream.write).to.have.been.calledWithExactly result, "utf-8", sinon.match.func
        (expect next).to.have.been.calledWithExactly error
