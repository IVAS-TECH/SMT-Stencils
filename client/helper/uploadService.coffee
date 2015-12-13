module.exports = (Upload, REST) ->
  @$inject = ["Upload", "REST"]

  (url) ->
    (files) ->
      Upload.upload
        url: "#{REST.base}/file/#{url}"
        data:
          files: files
