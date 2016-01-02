describe "Session", ->

  Session = undefined

  describe "constructor", ->

    beforeEach ->

      Session = require "./../Session"

    afterEach ->

      Session = undefined

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

    proxyquire = docs = mockSessionModel = undefined

    beforeEach ->

      proxyquire = require "proxyquire"

      proxyquire.noCallThru()

      docs = [
        {
          _id: "id0"
          ip: "ip"
          key: "key0"
          value: "{\"i\": 9}"
        }
        {
          _id: "id1"
          ip: "ip"
          key: "key1"
          value: "9"
        }
        {
          _id: "id2"
          ip: "ip"
          key: "key2"
          value: "[]"
        }
      ]

      mockSessionModel =
        find: (obj, callback) -> callback null, docs

    afterEach -> proxyquire.callThru()

    describe "ready", ->

      beforeEach ->

        Session = proxyquire "./../Session", "./sessionModel": mockSessionModel

      it "restores Session state from last request", ->

        session = new Session "ip"

        session.ready().then ->

          expect(session.isEmpty()).to.be.false

          expect(session.map).to.eql docs

          expect(session.get).to.eql
            key0: i: 9
            key1: 9
            key2: []

    describe "create", ->

      stub = firstReturn = secondReturn = firstCall = secondCall = session = undefined

      beforeEach (done) ->

        extend = require "extend"
        ip = "ip"

        firstCall =
          key: "first"
          value: "\"first\""
          ip: ip

        secondCall =
          key: "second"
          value: "\"second\""
          ip: ip

        firstReturn = id: "first"
        extend firstReturn, firstCall

        secondReturn = id: "second"
        extend secondReturn, secondCall

        mockSessionModel.create = (obj, callback) ->

        stub = sinon.stub mockSessionModel, "create"

        stub.onFirstCall().callsArgWith 1, null, firstReturn

        stub.onSecondCall().callsArgWith 1, null, secondReturn

        Session = proxyquire "./../Session", "./sessionModel": mockSessionModel

        session = new Session ip

        session.ready().then done

      it "extends session collection", ->
        create = session.create
          first: "first"
          second: "second"

        create.then ->

          expect(session.map.length).to.equal 5

          expect(session.map).to.contain firstReturn

          expect(session.map).to.contain secondReturn

          expect(stub).to.have.been.calledTwice

          expect(stub).to.have.been.calledWith firstCall

          expect(stub).to.have.been.calledWith secondCall
