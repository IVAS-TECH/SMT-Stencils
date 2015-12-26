module.exports = ->

  base = ""

  setBase: (b) -> base = b

  $get: (Upload, REST) ->
    @$inject = ["Upload", "REST"]

    (url) ->
      (files) ->
        Upload.upload
          url: [REST.base, base, url].join "\/"
          data: files: files
