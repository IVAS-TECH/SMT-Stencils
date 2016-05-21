describe "errorLogger", ->
    logger = morgan = log = req = undefined

    beforeEach ->
        morgan = sinon.stub()
        proxyquire = require "proxyquire"
        errorLogger = proxyquire "./../errorLogger", "morgan": morgan
        log = {}
        req = {}
        logger = errorLogger log

    it "should create new logger wich is combined, stream and shoud skip all successful requests", ->
        skip = morgan.firstCall.args[1].skip
        (expect morgan).to.have.been.calledWithExactly "combined", stream: log, skip: sinon.match.func
        (expect skip req, statusCode: 200).to.be.true
        (expect skip req, statusCode: 399).to.be.true
        (expect skip req, statusCodee: 400).to.be.false
        (expect skip req, statusCodee: 500).to.be.false
