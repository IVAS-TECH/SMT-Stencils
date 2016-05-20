describe "makeModel", ->
    makeModel = model = Schema = ObjectId = undefined

    beforeEach ->
        class ObjectId
        proxyquire = require "proxyquire"
        model = sinon.spy()
        Schema = sinon.spy()
        Schema.Types = ObjectId: ObjectId
        makeModel = sinon.spy proxyquire "./../makeModel", "mongoose":
            model: model
            Schema: Schema

    it "should convert [Contructor, value] to \n\t{\n\t\ttype: Constructor,\n\t\tdefault: value\n\t}", ->
        makeModel "Test", field: [String, "test"]
        (expect model).to.have.been.calledWith "Test"
        (expect Schema.calledWithNew()).to.be.true
        (expect Schema).to.have.been.calledWithExactly field:
            type: String
            default: "test"

    it "should leave [Contructor] unchanged", ->
        makeModel "Test", field: [String]
        (expect Schema).to.have.been.calledWithExactly field: [String]

    it "should properly convert relations eg. \"User\" to \n\t{\n\t\ttype: mongoose.Schema.Types.ObjectId,\n\t\treft: \"User\"\n\t}", ->
        makeModel "Test", field: "Collection"
        (expect Schema).to.have.been.calledWithExactly field:
            type: ObjectId
            ref: "Collection"

    it "if value is object and contains mongoose field it should treat this as configuration object not as a nested schema.", ->
        makeModel "Test", field:
            type: String
            unique: yes
            mongoose: yes
        (expect Schema).to.have.been.calledWithExactly field:
            type: String
            unique: yes

    it "should make a recursive call if value is object and it does not contains mongoose filed it treats it as nested chema", ->
        makeModel "Test",
            A: [String, "test"]
            B:
                name:
                    type: String
                    unique: yes
                    mongoose: yes
                type: Number
        (expect Schema).to.have.been.calledWithExactly
            A:
                type: String
                default: "test"
            B:
                name:
                    type: String
                    unique: yes
                type: type: Number

    it "should leave value unchanged if it hasn't already deducted it kind -> it is 99.9% a Constructor hope you know what you are doing in the other 0.01%", ->
        makeModel "Test", field: String
        (expect Schema).to.have.been.calledWithExactly field: String

    it "should convert {type: Constructor} to \n\t{\n\t\ttype: {type: Constructor}\n\t}", ->
        makeModel "Test", type: String
        (expect Schema).to.have.been.calledWithExactly type: type: String

    it "should properly convert the schema", ->
        makeModel "Test",
            A: [String, "test"]
            B:
                name:
                    type: String
                    unique: yes
                    mongoose: yes
                type: Number
                valid: Boolean
                relation: "Collection"
        (expect Schema).to.have.been.calledWithExactly
            A:
                type: String
                default: "test"
            B:
                name:
                    type: String
                    unique: yes
                type: type: Number
                valid: Boolean
                relation:
                    type: ObjectId
                    ref: "Collection"
