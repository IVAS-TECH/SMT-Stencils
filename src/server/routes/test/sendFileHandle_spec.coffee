describe "sendFileHandle", ->
    sendFileHandle = join = req = res = undefined

    beforeEach ->
        proxyquire = require "proxyquire"
        join = sinon.stub()
        req = {}
        res =
            status: sinon.stub()
            sendFile: sinon.spy()
        sendFileHandle = proxyquire "./../sendFileHandle", "path": join: join
        res.status.returns res

    it "sends a file from a given directory as \"text/html\"", ->
        handle = sendFileHandle "./test"
        join.returns "./test/test.html"
        req.params = file: "test.html"
        handle.get req, res
        (expect res.status).to.have.been.calledWithExactly 200
        (expect res.sendFile).to.have.been.calledWithExactly "./test/test.html", headers: "Content-Type": "text/html"
