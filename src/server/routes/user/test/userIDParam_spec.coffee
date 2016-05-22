describe "userIDParam", ->
    userIDParam = req = res = next = id = undefined

    beforeEach ->
        req = {}
        res = {}
        next = sinon.spy()
        userIDParam = require "./../userIDParam"

    it "should call next with new Error \"Unauthorized Access\"", ->
        userIDParam req, res, next, "id"
        error = next.firstCall.args[0]
        (expect error).to.be.instanceof Error
        (expect error.message).to.be.equal "Unauthorized Access"

    it "assigns user id if id is \"id\" to req.userID", ->
        _id = "9329493242"
        req.user = user: _id
        userIDParam req, res, next, "id"
        (expect req.userID).to.equal _id
        (expect next).to.have.been.called

    it "assigns id if id isn't \"id\" to req.userID", ->
        id = "9329493242"
        req.user = {}
        userIDParam req, res, next, id
        (expect req.userID).to.equal id
        (expect next).to.have.been.called
