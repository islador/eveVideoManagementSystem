# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  pst = "00:00"
  cst = "00:00"
  est = "00:00"
  $("#operation_eve_date_4i").on('change', ->
    raw_time_number = parseInt($("#operation_eve_date_4i").val())
    if raw_time_number - 8 < 0
      time_number = raw_time_number + 24 - 8
    else
      time_number = raw_time_number - 8

    time_string = time_number.toString()
    if time_string.length < 2
      time_string = "0" + time_string

    pst = time_string + pst.substr(2,4)
    $(".time-preview__pst-container .time").text(pst)
  )

  $("#operation_eve_date_5i").on('change', ->

    pst = pst.substr(0,3) + $("#operation_eve_date_5i").val()
    $(".time-preview__pst-container .time").text(pst)
  )

  $("#operation_eve_date_4i").on('change', ->
    raw_time_number = parseInt($("#operation_eve_date_4i").val())
    if raw_time_number - 6 < 0
      time_number = raw_time_number + 24 - 6
    else
      time_number = raw_time_number - 6

    time_string = time_number.toString()
    if time_string.length < 2
      time_string = "0" + time_string

    cst = time_string + cst.substr(2,4)
    $(".time-preview__cst-container .time").text(cst)
  )

  $("#operation_eve_date_5i").on('change', ->

    cst = cst.substr(0,3) + $("#operation_eve_date_5i").val()
    $(".time-preview__cst-container .time").text(cst)
  )

  $("#operation_eve_date_4i").on('change', ->
    raw_time_number = parseInt($("#operation_eve_date_4i").val())
    if raw_time_number - 5 < 0
      time_number = raw_time_number + 24 - 5
    else
      time_number = raw_time_number - 5

    time_string = time_number.toString()
    if time_string.length < 2
      time_string = "0" + time_string

    est = time_string + est.substr(2,4)
    $(".time-preview__est-container .time").text(est)
  )

  $("#operation_eve_date_5i").on('change', ->

    est = est.substr(0,3) + $("#operation_eve_date_5i").val()
    $(".time-preview__est-container .time").text(est)
  )

