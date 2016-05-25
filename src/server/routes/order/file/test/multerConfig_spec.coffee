describe "multerConfig", ->
    multer = generate = config = undefined

    beforeEach ->
        generate = sinon.stub()
        multer = sinon.spy()
        multer.diskStorage = sinon.spy()
        proxyquire = require "proxyquire"
        multerConfig = proxyquire "./../multerConfig",
            "multer": multer
            "randomstring": generate: generate
        config = multerConfig "./test"
        generate.returns "1k9a73nn86"

    describe ".preview", ->
        it "sets destination to dir + \"/tmp\"", ->
            config.preview()
            {destination} = multer.diskStorage.firstCall.args[0]
            (expect destination).to.equal "./test/tmp"

    describe ".order", ->
        it "sets destination to dir", ->
            config.order()
            {destination} = multer.diskStorage.firstCall.args[0]
            (expect destination).to.equal "./test"

    describe ".*.filename", ->
        filename = callback = req = undefined

        beforeEach ->
            config.preview()
            callback = sinon.spy()
            {filename} = multer.diskStorage.firstCall.args[0]
            req = user: user: _id: "9392423964"

        it "should concatinate req.user.user._id, generate() & name + extention with \"___\"", ->
            file = originalname: "test.gko"
            filename req, file, callback
            (expect callback).to.have.been.calledWithExactly null, "9392423964___1k9a73nn86___test.gko"

        it "uses file name as extention if the file dosen't have one", ->
            file = originalname: "gko"
            filename req, file, callback
            (expect callback).to.have.been.calledWithExactly null, "9392423964___1k9a73nn86___gko.gko"
