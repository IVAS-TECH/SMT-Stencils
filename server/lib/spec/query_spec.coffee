describe "query", ->

  query = require "./../query"

  describe "query checks", ->

    before -> query = require "./../query"

    describe "successful", ->

      it "returns true if db query is successful", ->

        expect(query.successful null, _id: "some id").to.be.true

      it "returns false if db query failed", ->

        expect(query.successful new Error(), _id: "some id").to.be.false

        expect(query.successful new Error()).to.be.false

      describe "noErr", ->

        it "returns true if thre is no db query error", ->

          expect(query.noErr null).to.be.true

        it "returns false if thre was a db query error", ->

          expect(query.noErr new Error()).to.be.false

    describe "basicHandle", ->

      next = send = undefined

      beforeEach ->

        send = sinon.spy (res) ->

        next = sinon.spy (err) ->

        proxyquire = require "proxyquire"

        query = proxyquire "./../query", "./send": send

      it "sends if db query was successfull", ->

        res = {}

        query.basicHandle null, {}, res, ->

        expect(send).to.have.been.calledWith res

      it "passes err no req pipe if there was error", ->

        e = new Error()

        res = {}

        query.basicHandle e, {}, res, next

        expect(send).to.have.not.been.calledWith res

        expect(next).to.have.been.calledWith e
