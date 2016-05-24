describe "getDescriptionTemplate", ->
    getDescriptionTemplate = join = readFile = error = template = undefined

    beforeEach ->
        join = sinon.stub()
        readFile = sinon.stub()
        template = split: sinon.stub()
        error = new Error()
        proxyquire = require "proxyquire"
        join.returns "./descriptionTemplates"
        getDescriptionTemplate = proxyquire "./../getDescriptionTemplate",
            "path": join: join
            "fs": readFile: readFile
        join.returns "./descriptionTemplates/rejected_en.txtmp"
        template.split.returns ["Your order with id:", "&@_id", "has been rejected!"]

    it "resolves with array of lines if there is no error", (done) ->
        readFile.callsArgWith 2, null, template
        (getDescriptionTemplate "rejected", "en").then (tmp) ->
            (expect readFile).to.have.been.calledWithExactly "./descriptionTemplates/rejected_en.txtmp", "utf8", sinon.match.func
            (expect tmp).to.eql ["Your order with id:", "&@_id", "has been rejected!"]
            done()

    it "rejects with error if readFile resulted into one", (done) ->
        readFile.callsArgWith 2, error
        (getDescriptionTemplate "rejected", "en").then null, (err) ->
            (expect err).to.eql error
            done()
