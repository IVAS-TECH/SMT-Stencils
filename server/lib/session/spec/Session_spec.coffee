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

    proxyquire = docs = mockSessionModel = undefined

    beforeEach ->

      proxyquire = require "proxyquire"

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

    describe "restore", ->

      beforeEach ->

        Session = proxyquire "./../Session", "./sessionModel": mockSessionModel

      it "restores Session state from last request", ->

        session = new Session "ip"

        session.restore().then ->

          expect(session.isEmpty()).to.be.false

          expect(session.map).to.eql docs

          expect(session.get).to.eql
            key0: i: 9
            key1: 9
            key2: []

    describe "create and update", ->

      find = undefined

      beforeEach ->

        mockSessionModel.findByIdAndUpdate = ->

        find = sinon.stub mockSessionModel, "findByIdAndUpdate", (id, query, opts, callback) ->
          doc = query.$set
          doc._id = id
          callback null, doc

      afterEach -> find.restore()

      describe "create", ->

        spy = stub = firstReturn = secondReturn = firstCall = secondCall = session = undefined

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

          stub = sinon.stub()

          stub.onFirstCall().callsArgWith 1, null, firstReturn

          stub.onSecondCall().callsArgWith 1, null, secondReturn

          mockSessionModel.create = stub

          Session = proxyquire "./../Session", "./sessionModel": mockSessionModel

          session = new Session ip

          spy = sinon.spy session, "update"

          session.restore().then done

        afterEach -> spy.restore()

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

        it "calls update if item exists in the collection", ->

          (session.create
            key0: 0
            key1: 1
            key2: 2).then ->

            expect(spy).to.have.been.calledThrice

      describe "update", ->

        session = undefined

        beforeEach (done) ->

          Session = proxyquire "./../Session", "./sessionModel": mockSessionModel

          session = new Session "ip"

          session.restore().then done

        it "updates the collection", ->

          expect(session.map.length).to.equal 3

          expect(session.get.key0).to.eql i: 9

          (session.update key0: 0).then ->

            set =
              ip: "ip"
              key: "key0"
              value: "0"

            expect(find).to.have.been.calledWithMatch "id0", $set: set, {new: true}

            expect(session.map.length).to.equal 3

            expect(session.get.key0).to.eql 0

            set._id = "id0"

            expect(session.map).to.contains set

    describe "remove, destroy and delete", ->

      spy = session = undefined

      beforeEach (done) ->

        mockSessionModel.remove = (obj, callback) ->
          callback null

        spy = sinon.spy mockSessionModel, "remove"

        Session = proxyquire "./../Session", "./sessionModel": mockSessionModel

        session = new Session "ip"

        session.restore().then done

      afterEach -> spy.restore()

      describe "remove", ->

        it "shrinks the collection and DB", ->

          expect(session.map.length).to.equal 3

          (session.remove "key0").then ->

            expect(session.map.length).to.be.below 3

            expect(session.map.length).to.be.above 1

            expect(spy).to.have.been.calledWith _id: "id0"

      describe "delete", ->

        remove = undefined

        beforeEach ->

          remove = sinon.spy session, "remove"

        afterEach = -> remove.restore()

        it "calls remove when called with key: String", ->

          (session.delete "key0").then ->

            expect(remove).to.have.been.calledWith "key0"

        it "calls remove for each when called with key: Arrat", ->

          (session.delete ["key0", "key1", "key2"]).then ->

            expect(remove).to.have.been.calledThrice

            expect(remove).to.have.been.calledWith "key0"

            expect(remove).to.have.been.calledWith "key1"

            expect(remove).to.have.been.calledWith "key2"

            expect(session.isEmpty()).to.be.true

      describe "destroy", ->

        it "restores session state to new", ->

          session.destroy().then ->

            expect(spy).to.have.been.calledWith ip: "ip"

            expect(session.map).to.eql []

            expect(session.get).to.eql {}

            expect(session.isEmpty()).to.be.true

  describe "functionality when DB Query is not successful", ->

    simpleCallback = error = proxyquire = session = undefined

    before ->

      proxyquire = require "proxyquire"

      error = new Error()

      simpleCallback = (obj, callback) -> callback error, null

      mockedStore =
        find: simpleCallback
        findByIdAndUpdate: (id, query, opts, callback) ->
          simpleCallback query, callback
        create: simpleCallback
        remove: simpleCallback

      Session = proxyquire "./../Session",
        "./sessionModel": mockedStore

      session = new Session "ip"

    tests = [
      {
        method: "restore"
        args: []
      }
      {
        method: "create"
        args: [uid: "id"]
      }
      {
        method: "update"
        args: [uid: "uid"]
      }
      {
        method: "remove"
        args: ["uid"]
      }
      {
        method: "delete"
        args: ["uid"]
      }
      {
        method: "destroy"
        args: []
      }
    ]

    for test in tests

      it "rejects when calling #{test.method} and DB Qeuery fails", ->

        promise = session[test.method].apply null, test.args

        expect(promise).to.be.rejectedWith error

    describe "remove when empty", ->

      promise = spy = undefined

      beforeEach (done) ->

        spy = sinon.spy simpleCallback

        Session = proxyquire "./../Session", "./sessionModel": remove: spy

        session = new Session "ip"

        promise = session.remove "uid"

        promise.then null, done

      it "rejects when empty", ->

        expect(spy).not.to.have.been.called
