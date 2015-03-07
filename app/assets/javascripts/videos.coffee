# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  date = new Date

  $("#s3-uploader").S3Uploader
    path: "videos/year/#{date.getFullYear()}/month/#{date.getMonth()}/operation/#{$("#operation_id").val()}/"
    additional_data: {operation_id: $("#operation_id").val()}

  $("#operation_id").on("change", ->
    console.log("Value: ", $("#operation_id").val())
    )
