module.exports = (RESTProvider) ->
  @$inject = ["RESTProvider"]

  base = ""

  setBase: (b) -> base = b

  $get: (Upload, REST) ->
    @$inject = ["Upload"]

    (url) ->
      (files) ->
        Upload.upload
          url: [RESTProvider.getBase(), base, url].join "\/"
          data: files: files
