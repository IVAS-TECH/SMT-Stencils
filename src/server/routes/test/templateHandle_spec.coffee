describe "templateHandle", ->
    join = sendFileMiddleware = sendTemplate = send = templateHandle = undefined

    beforeEach ->
        proxyquire = require "proxyquire"
        join = sinon.stub()
        sendFileMiddleware = sinon.stub()
        sendTemplate = sinon.stub()
        send = sinon.spy()
        join.returns "./send/templates"
        sendFileMiddleware.returns sendTemplate
        sendTemplate.returns send
        templateHandle = proxyquire "./../templateHandle",
            "path": join: join
            "./sendFileMiddleware": sendFileMiddleware

    it "sends coresponding file for the template param", ->
        req = {}
        res = {}
        req.params = template: "test"
        templateHandle.get req, res
        (expect sendTemplate).to.have.been.calledWithExactly req.params.template
        (expect send).to.have.been.calledWithExactly req, res
