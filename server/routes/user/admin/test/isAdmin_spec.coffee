describe "isAdmin", ->

  stub = isAdmin = undefined

  admin = access: 2

  error = new Error()

  before ->

    adminModel =
      findOne: (obj, callback) ->

    stub = sinon.stub adminModel, "findOne"

    stub.withArgs(user: "id1").callsArgWith 1, null, null

    stub.withArgs(user: "id2").callsArgWith 1, null, admin

    stub.withArgs(user: "id3").callsArgWith 1, error, null

    proxyquire = require "proxyquire"

    isAdmin = proxyquire "./../isAdmin", "./adminModel": adminModel

  after -> stub.restore()

  describe "when provided id isn't asociated with an admin", ->

    it "resolves with {admin: false}", ->

      (isAdmin "id1").then (res) ->

        expect(res.admin).to.be.false

        expect(res).to.not.have.property "access"

  describe "when provided id is asociated with an admin", ->

    it "resolves with {admin: true access: Number}", ->

      (isAdmin "id2").then (res) ->

        expect(res.admin).to.be.true

        expect(res.access).to.equal admin.access

  describe "when there is an error", ->

    it "reject with error", ->

      (isAdmin "id3").then null, (err) ->

        expect(err).to.eql error
