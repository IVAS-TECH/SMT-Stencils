describe "query", ->
    query = res = obj = undefined

    beforeEach ->
        query = sinon.spy require "./../query"
        res =
            setHeader: sinon.spy()
            status: sinon.stub()
            send: sinon.spy()
        res.status.returnsThis res

    it "should have a predefined behavour", ->
        query res, obj
        (expect query).to.have.been.calledWithExactly res, obj
        (expect res.setHeader).to.have.been.calledWithExactly "Cache-Control", "public, max-age=50"
        (expect res.status).to.have.been.calledWithExactly 200
        (expect res.send).to.have.been.calledWithExactly {}

    it "should send what have been passed", ->
        obj = ivo: 9
        query res, obj
        (expect res.send).to.have.been.calledWithExactly obj

    it "should throw exception if res isn't the same as the request arg", ->
        (expect query).to.throw TypeError
