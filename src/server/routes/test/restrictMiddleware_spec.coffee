describe "restrictMiddleware", ->
    restrictMiddleware = req = res = next = undefined

    beforeEach ->
        restrictMiddleware = require "./../restrictMiddleware"
        next = sinon.spy()
        req = {}
        res = {}

    it "just calls next if session is avalibe (req object has user object)", ->
        req.user = {}
        restrictMiddleware req, res, next
        (expect next).to.have.been.called

    it "calls next if req.method is get or post and req.url is /login", ->
        req.url = "/login"
        req.method = "GET"
        restrictMiddleware req, res, next
        (expect next).to.have.been.called
        req.method = "POST"
        restrictMiddleware req, res, next
        (expect next).to.have.been.called

    it "calls next if req.method is post and req.url is /user", ->
        req.url = "/user"
        req.method = "POST"
        restrictMiddleware req, res, next
        (expect next).to.have.been.called

    it "calls next if req.method is put and req.url match /user, eg. it is /user/:email", ->
        req.url = "/user/test@test.com"
        req.method = "PUT"
        restrictMiddleware req, res, next
        (expect next).to.have.been.called

    it "calls next with new Error if rout requires authentication (session) and none is found", ->
        req.url = "/user"
        req.method = "DELETE"
        restrictMiddleware req, res, next
        error = next.firstCall.args[0]
        (expect error).to.be.instanceof Error
        (expect error.message).to.be.equal "Unauthorized Access"
        req.url = "/test"
        restrictMiddleware req, res, next
        error = next.secondCall.args[0]
        (expect error).to.be.instanceof Error
