tested = require "./../RESTHelperService"

describe "RESTHelperService", ->

  errorHandleService = request = REST = RESTHelperService = uploadService = undefined

  data = someData: "data"

  email = "email@email"

  callback = jasmine.createSpy()

  beforeEach ->

    resolve = (callback) ->
      callback
        status: 200
        data: data

    request = jasmine.createSpy()

    request.and.callFake (send) ->
      then: resolve

    REST = jasmine.createSpy()

    REST.and.callFake (rest) ->
      get: request
      post: request
      put: request
      delete: request
      patch: request

    uploadService = jasmine.createSpy()

    uploadService.and.callFake (upload) ->
      request

    errorHandleService = jasmine.createSpy()

    RESTHelperService = tested REST, uploadService, errorHandleService

  describe "when error", ->

    spy = undefined

    reject = (callback) ->
      callback
        status: 500

    beforeEach ->

      spy = jasmine.createSpy()

      request.and.callFake (send) ->
        then: reject

    it "should call errorHandleService if status isn't 200", ->

      spy = jasmine.createSpy()

      RESTHelperService.login.logged spy

      expect(spy).not.toHaveBeenCalled()

      expect(errorHandleService).toHaveBeenCalled()

    it "should call errorHandleService if request failed due to an error", ->

      request.and.callFake (send) ->
        then: (res, rej) -> rej()

      RESTHelperService.login.logged spy

      expect(spy).not.toHaveBeenCalled()

      expect(errorHandleService).toHaveBeenCalled()

  describe "all request makers", ->

    it "creates restfull 'apis'", ->

      for called in ["login", "user", "configuration", "addresses", "order", "description"]

        expect(REST).toHaveBeenCalledWith called

    it "creates file uploaders", ->

      for called in ["preview", "order"]
        expect(uploadService).toHaveBeenCalledWith called

  describe "RESTHelperService.upload.[]", ->

    files = ["file1", "file2"]

    run = (test) ->

      it "uploads files for #{test}", ->

        RESTHelperService.upload[test] files, callback

        expect(request).toHaveBeenCalledWith files

        expect(callback).toHaveBeenCalled()

    run test for test in ["preview", "order"]

  describe "RESTHelperService.email", ->

    it "checks if email is taken", ->

      RESTHelperService.user.email email, callback

      expect(request).toHaveBeenCalledWith email

      expect(callback).toHaveBeenCalled()

  describe ".register, .login and .profile", ->

    user =
      email: email
      password: "password"

    run = (test) ->

      key = if test isnt "login" then "user" else test

      describe "RESTHelperService.#{key}.#{test}", ->

        message = "#{test} a new user"

        if test is "profile"
          message = "changes user's email/password"

        it message, ->

          RESTHelperService[key][test] user , callback

          expect(request).toHaveBeenCalledWith user

          expect(callback).toHaveBeenCalled()

    run test for test in ["register", "login", "profile"]

  testLog = (log) ->

    describe "RESTHelperService.login.#{log}", ->

      message = "checks if a user is currrently logged (for session)"

      if log is "logout"
        message = "logouts a user (destroies session)"

      it message, ->

        RESTHelperService.login[log] callback

        expect(callback).toHaveBeenCalled()

  testLog log for log in ["logged", "logout"]

  testWhat = (what, tests) ->

    describe "RESTHelperService.#{what}.[]", ->

      run = (test) ->

        if test is "find"

          it "gets all user related #{what}", ->

            RESTHelperService[what].find callback

            expect(callback).toHaveBeenCalled()

        else

          it "#{test}s #{what}", ->

            RESTHelperService[what][test] {}, callback

            expect(request).toHaveBeenCalledWith {}

            expect(callback).toHaveBeenCalled()

      run test for test in tests

  testWhat what, ["create", "find", "delete", "update"] for what in ["configuration", "addresses"]

  testWhat "order", ["create", "find", "view"]

  describe "RESTHelperService.description.[]", ->

    tests = [
      {
        msg: "tries to get"
        arg: "id"
      }
      {
        msg: "creates"
        arg:
          id: "id"
          text: ["some", "text"]
      }
    ]

    run = (test) ->

      it "#{test.msg} order description", ->

        RESTHelperService.description.find test.arg , callback

        expect(request).toHaveBeenCalledWith test.arg

        expect(callback).toHaveBeenCalled()

    run test for test in tests
