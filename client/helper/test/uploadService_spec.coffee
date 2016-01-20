describe "uploadService", ->

  uploadService = undefined

  files = {
    top: name: "top.gbr"
    outline: name: "outline.gbr"
  }

  expected = {
    files: [
      {name: "top.gbr"}
      {name: "outline.gbr"}
    ]
    map: {
      "top.gbr": "top"
      "outline.gbr": "outline"
    }
  }

  upload = jasmine.createSpy()

  tested = require "./../uploadService"

  describe "upload on single url", ->

    RESTProvider = getBase: -> ""

    uploadService = tested RESTProvider

    uploader = (uploadService.$get upload: upload) "order"

    uploader files

    it "upload files on passed url", ->

      expect(upload).toHaveBeenCalledWith
        url: "/order"
        data: expected

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
          data: expected
