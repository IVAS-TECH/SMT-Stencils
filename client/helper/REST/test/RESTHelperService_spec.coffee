tested = require "./../RESTHelperService"

describe "RESTHelperService", ->

  request = REST = RESTHelperService = uploadService = undefined

  data = someData: "data"

  email = "email@email"

  callback = jasmine.createSpy()

  beforeEach ->

    resolve = (callback) ->
      callback
        statusCode: 200
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

    RESTHelperService = tested REST, uploadService

  describe "all request makers", ->

    it "creates restfull 'apis'", ->

      expect(REST).toHaveBeenCalledWith "login"

      expect(REST).toHaveBeenCalledWith "user"

      expect(REST).toHaveBeenCalledWith "config"

      expect(REST).toHaveBeenCalledWith "addresses"

      expect(REST).toHaveBeenCalledWith "order"

    it "creates file uploaders", ->

      expect(uploadService).toHaveBeenCalledWith "preview"

      expect(uploadService).toHaveBeenCalledWith "order"

  describe "RESTHelperService.upload.[]", ->

    files = ["file1", "file2"]

    it "uploads files for preview", ->

      RESTHelperService.upload.preview files, callback

      expect(request).toHaveBeenCalledWith files

      expect(callback).toHaveBeenCalled()

    it "uploads files for order", ->

      RESTHelperService.upload.order files, callback

      expect(request).toHaveBeenCalledWith files

      expect(callback).toHaveBeenCalled()

  describe "RESTHelperService.email", ->

    it "checks if email is taken", ->

      RESTHelperService.email email, callback

      expect(request).toHaveBeenCalledWith email

      expect(callback).toHaveBeenCalled()

  describe ".register, .login and .profile", ->

    user =
      email: email
      password: "password"

    describe "RESTHelperService.register", ->

      it "register a new user", ->

        RESTHelperService.register user , callback

        expect(request).toHaveBeenCalledWith user

        expect(callback).toHaveBeenCalled()

    describe "RESTHelperService.login", ->

      it "register a new user", ->

        RESTHelperService.login user , callback

        expect(request).toHaveBeenCalledWith user

        expect(callback).toHaveBeenCalled()

    describe "RESTHelperService.profile", ->

      it "changes user's email/password", ->

        RESTHelperService.profile user , callback

        expect(request).toHaveBeenCalledWith user

        expect(callback).toHaveBeenCalled()

  describe "RESTHelperService.logged", ->

    it "checks if a user is currrently logged (for session)", ->

      RESTHelperService.logged callback

      expect(callback).toHaveBeenCalled()

  describe "RESTHelperService.logout", ->

    it "logouts a user (destroies session)", ->

      RESTHelperService.logout callback

      expect(callback).toHaveBeenCalled()
