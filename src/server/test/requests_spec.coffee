describe "requests", ->
    join = express = createWriteStream = gcloud = storage = bucket = buck = res = req = next = requests = proxy = undefined

    beforeEach ->
        join = sinon.stub()
        createWriteStream = sinon.stub()
        express = static: sinon.spy()
        gcloud = sinon.stub()
        storage = sinon.stub()
        bucket = sinon.stub()
        res = set: sinon.spy()
        buck = {}
        req = {}
        next = sinon.spy()
        proxyqire = require "proxyquire"
        proxy = -> requests = proxyqire "./../requests",
            "path": join: join
            "fs": createWriteStream: createWriteStream
            "express": express
            "gcloud": gcloud
        (join.withArgs sinon.match.string, "logs/error.log").returns "./logs/error.log"
        (join.withArgs sinon.match.string, "send").returns "./send"
        createWriteStream.returns {}
        gcloud.returns storage: storage
        storage.returns bucket: bucket
        bucket.returns buck

    describe ".beforeEach", ->
        describe "[2]", ->
            beforeEach -> proxy()

            it "should call express.static and add setHeaders function", ->
                (expect createWriteStream ).to.have.been.calledWithExactly "./logs/error.log", flags: "a"
                (expect express.static).to.have.been.calledWithExactly "./send", setHeaders: sinon.match.func

            describe "setHeaders", ->
                it "sets \"Content-Encoding\" to \"gzip\"", ->
                    {setHeaders} = express.static.firstCall.args[1]
                    setHeaders res, "test.html", {}
                    (expect res.set).to.have.been.calledWithExactly "Content-Encoding", "gzip"

        describe "[3]", ->
            it "shouldn't set req.fileStorage", ->
                proxy()
                requests.beforeEach[3] req, res, next
                (expect gcloud).to.have.not.been.called
                (expect storage).to.have.not.been.called
                (expect bucket).to.have.not.been.called
                (expect req.fileStorage).to.be.undefined
                (expect next).to.have.been.called

            it "should set req.fileStorage to bucket object", ->
                process.env.Project_ID = "test"
                proxy()
                requests.beforeEach[3] req, res, next
                (expect gcloud).to.have.been.calledWithExactly projectId: "test"
                (expect storage).to.have.been.called
                (expect bucket).to.have.been.calledWithExactly "test"
                (expect req.fileStorage).to.eql buck
                (expect next).to.have.been.called

    describe ".afterEach", ->
        beforeEach -> proxy()

        describe "[0]", ->
            it "calls next with new Error with message \"Not Found\"", ->
                requests.afterEach[0] req, res, next
                error = next.firstCall.args[0]
                (expect next).to.have.been.calledWithExactly sinon.match.instanceOf Error
                (expect error.message).to.equal "Not Found"
