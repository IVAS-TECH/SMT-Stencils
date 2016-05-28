describe "errorHandler", ->
    errorHandler = errorStream = redirect = err = undefined
    req = res = next = send = handler = undefined

    beforeEach ->
        errorHandler = require "./../errorHandler"
        errorStream = write: sinon.spy()
        redirect = "/test"
        req = {}
        res = status: sinon.stub()
        send =
            redirect: sinon.spy()
            send: sinon.spy()
        res.status.returns send
        handler = errorHandler errorStream, redirect

    it "should redirect if err.message is \"Not Found\"", ->
        err = new Error "Not Found"
        err.stack = "stack"
        handler err, req, res
        (expect res.status).to.have.been.calledWithExactly 404
        (expect send.redirect).to.have.been.calledWithExactly redirect
        (expect errorStream.write).to.have.not.been.called

    it "should send error object if err.message is \"Unauthorized Access\"", ->
        message = "Unauthorized Access"
        err = new Error message
        err.stack = "other stack\n"
        handler err, req, res
        (expect res.status).to.have.been.calledWithExactly 401
        (expect send.send).to.have.been.calledWithExactly
            error: 401
            message: message
        (expect errorStream.write).to.have.been.calledWithExactly "other stack\n\n", "utf-8"

    it "should send a default generic message if unknown type of error occured", ->
        err = new Error()
        handler err, req, res
        (expect res.status).to.have.been.calledWithExactly 500
        (expect send.send).to.have.been.calledWithExactly
            error: 500
            message: "Internal Server Error"
