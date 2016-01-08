describe "uploadService", ->

  uploadService = undefined

  files = ["file1", "file2"]

  upload = jasmine.createSpy()

  tested = require "./../uploadService"

  describe "upload on single url", ->

    RESTProvider = getBase: -> ""

    uploadService = tested RESTProvider

    uploader = (uploadService.$get upload: upload) "order"

    uploader files

    it "upload files on passed url", ->

      expect(upload).toHaveBeenCalledWith
        url: "order"
        data: files: files

  describe "with chained url", ->

    RESTProvider = getBase: -> "api"

    uploadService = tested RESTProvider

    describe "setBase", ->

      it "sets base path", ->

        expect(uploadService.getBase()).not.toEqual "file"

        uploadService.setBase "file"

        expect(uploadService.getBase()).toEqual "file"

    describe "upload", ->

      it "upload files on chained url", ->

        uploadService.setBase "file"

        uploader = (uploadService.$get upload: upload) "order"

        uploader files

        expect(upload).toHaveBeenCalledWith
          url: "api/file/order"
          data: files: files
