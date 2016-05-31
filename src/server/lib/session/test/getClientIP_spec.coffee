describe "getClientIP", ->
    requestIp = req = getClientIP = undefined

    beforeEach ->
        requestIp = getClientIp: sinon.stub()
        req = headers: {}
        proxyquire = require "proxyquire"
        getClientIP = proxyquire "./../getClientIP", "request-ip": requestIp
        requestIp.getClientIp.returns "169.154.13.17"

    it "should use \"x-appengine-user-ip\" header if it is defined", ->
        req.headers["x-appengine-user-ip"] = "130.12.34.56"
        (expect getClientIP req).to.equal req.headers["x-appengine-user-ip"]
        (expect requestIp.getClientIp).to.have.not.been.called

    it "should call requestIp.getClientIp if \"x-appengine-user-ip\" header isn\t defined", ->
        (expect getClientIP req).to.equal "169.154.13.17"
        (expect requestIp.getClientIp).to.have.been.calledWithExactly req
