describe "Session", ->

  Session = undefined

  describe "constructor", ->

    beforeEach ->

      Session = require "./../Session"

    it "creates new empty Session", ->

      session = new Session "127.0.0.1"

      expect(session.ip).to.equal "127.0.0.1"

      expect(session.map).to.eql []

      expect(session.get).to.eql {}

      expect(session.isEmpty()).to.be.true

  describe "add", ->

    session = doc = undefined

    beforeEach ->

      Session = require "./../Session"

      session = new Session "127.0.0.1"

      doc =
        _id: "id"
        ip: "127.0.0.1"
        key: "key"
        value: "0"

      session.add doc

    it "pushes new element to @map and asigns proper getter in @get", ->

      expect(session.isEmpty()).to.be.false

      expect(session.map[0]).to.eql doc

      expect(session.get.key).to.equal 0

    it "updates element from the session state", ->

      update =
        _id: "not id"
        ip: "127.0.0.1"
        key: "key"
        value: "9"

      session.add update, 0

      expect(session.map[0]).to.eql update

      expect(session.get.key).to.equal 9

  describe "functionality when DB Query is successful", ->

    docs = proxyquire = mockSessionModel = undefined

    beforeEach ->

      proxyquire = require "proxyquire"

      docs = [
        {
          _id: "id0"
          ip: "ip"
          key: "key0"
          value: "{'i': 9}"
        }
        {
          _id: "id1"
          ip: "ip1"
          key: "key1"
          value: "9"
        }
        {
          _id: "id2"
          ip: "ip"
          key: "key2"
          value: "'9'"
        }
        {
          _id: "id3"
          ip: "ip"
          key: "key3"
          value: "[]"
        }
      ]

      mockSessionModel =
        find: (obj, callback) -> callback null, docs

    describe "ready", ->

      session = undefined

      beforeEach ->

        Session = proxyquire "./../Session", "./sessionModel": mockSessionModel

        session = new Session "ip"

      it "restores Session state from last request", (done) ->

        session.ready().then -> done()
