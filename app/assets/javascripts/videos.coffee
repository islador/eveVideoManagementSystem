# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#video_filmed_on').datepicker()

  date = new Date

  $("#s3-uploader").S3Uploader(
    # Filetype validations
    before_add: (file) ->
      if /(\video|\/)(quicktime|x-msvideo|avi|x-msvideo)$/i.test(file.type)
        true
      else
        false
    path: "videos/year/#{date.getFullYear()}/month/#{date.getMonth()}/operation/#{$("#video_operation_id").val()}/"
    additional_data: {video: {operation_id: $("#video_operation_id").val(), kind: $("#video_kind").val(), filmed_on: $("#video_filmed_on").datepicker("getDate")}}
    progress_bar_target: $('.js-progress-bars')
    allow_multiple_files: false
  )
  $('#s3-uploader').bind 's3_uploads_start', (e) ->
    $(".new_video").hide()
    $("#s3-uploader").hide()
    $(".js-progress-bars").removeClass("hidden")

  $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
    $("#video_s3_url").val(content.url)
    $("#video_name").val(content.filename)
    $("#video_submit").click()

  $("#video_kind").on('change', ->
    if $("#video_kind").val() == "edited"
      no_operation = $("#video_operation_id option:contains(No Operation)").val()

      $("#video_operation_id").val(no_operation)
      $("form.new_video .operation_id").hide()
    else
      $("#video_operation_id").val(null)
      $("form.new_video .operation_id").show()
  )
