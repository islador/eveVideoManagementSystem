# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  pst_time = () ->
    if $(".dst").data("dst")
      7
    else
      8
  cst_time = () ->
    if $(".dst").data("dst")
      5
    else
      6
  est_time = () ->
    if $(".dst").data("dst")
      4
    else
      5
  # Calculate op prep start in PST, CST and EST
  $("#operation_op_prep_start_4i").on('change', ->
    # Retrieve the raw time number from the select
    raw_time_number = parseInt($("#operation_op_prep_start_4i").val())

    # Adjust the raw time number for pst
    if raw_time_number - pst_time() < 0
      pst_time_number = raw_time_number + 24 - pst_time()
    else
      pst_time_number = raw_time_number - pst_time()
    # Adjust the raw time number for cst
    if raw_time_number - cst_time() < 0
      cst_time_number = raw_time_number + 24 - cst_time()
    else
      cst_time_number = raw_time_number - cst_time()
    # Adjust the raw time number for est
    if raw_time_number - est_time() < 0
      est_time_number = raw_time_number + 24 - est_time()
    else
      est_time_number = raw_time_number - est_time()

    # Set the data attribute to the adjusted time number
    $(".op-prep-start-time .time-preview__pst-container .time").data('time-hour', pst_time_number)
    $(".op-prep-start-time .time-preview__cst-container .time").data('time-hour', cst_time_number)
    $(".op-prep-start-time .time-preview__est-container .time").data('time-hour', est_time_number)

    # Convert the time number into a string
    pst_time_string = pst_time_number.toString()
    cst_time_string = cst_time_number.toString()
    est_time_string = est_time_number.toString()

    # Format the time string for display
    if pst_time_string.length < 2
      pst_time_string = "0" + pst_time_string
    if cst_time_string.length < 2
      cst_time_string = "0" + cst_time_string
    if est_time_string.length < 2
      est_time_string = "0" + est_time_string
    pst_op_prep_start_time = pst_time_string + ":" + $(".op-prep-start-time .time-preview__pst-container .time").data('time-minute').toString()
    cst_op_prep_start_time = cst_time_string + ":" + $(".op-prep-start-time .time-preview__cst-container .time").data('time-minute').toString()
    est_op_prep_start_time = est_time_string + ":" + $(".op-prep-start-time .time-preview__est-container .time").data('time-minute').toString()

    # Display the time string
    $(".op-prep-start-time .time-preview__pst-container .time").text(pst_op_prep_start_time)
    $(".op-prep-start-time .time-preview__cst-container .time").text(cst_op_prep_start_time)
    $(".op-prep-start-time .time-preview__est-container .time").text(est_op_prep_start_time)
  )
  # Calculate op prep start in PST, CST and EST
  $("#operation_op_prep_start_5i").on('change', ->
    # Set the data attributes to the value of the select
    $(".op-prep-start-time .time-preview__pst-container .time").data('time-minute', $("#operation_op_prep_start_5i").val())
    $(".op-prep-start-time .time-preview__cst-container .time").data('time-minute', $("#operation_op_prep_start_5i").val())
    $(".op-prep-start-time .time-preview__est-container .time").data('time-minute', $("#operation_op_prep_start_5i").val())

    # Format the time string for display
    pst_op_prep_start_time = $(".op-prep-start-time .time-preview__pst-container .time").data('time-hour').toString() + ":" + $("#operation_op_prep_start_5i").val()
    cst_op_prep_start_time = $(".op-prep-start-time .time-preview__cst-container .time").data('time-hour').toString() + ":" + $("#operation_op_prep_start_5i").val()
    est_op_prep_start_time = $(".op-prep-start-time .time-preview__est-container .time").data('time-hour').toString() + ":" + $("#operation_op_prep_start_5i").val()

    # Display the time string
    $(".op-prep-start-time .time-preview__pst-container .time").text(pst_op_prep_start_time)
    $(".op-prep-start-time .time-preview__cst-container .time").text(cst_op_prep_start_time)
    $(".op-prep-start-time .time-preview__est-container .time").text(est_op_prep_start_time)
  )

  # Calculate op departure time in PST, CST and EST
  $("#operation_op_departure_4i").on('change', ->
    # Retrieve the raw time number from the select
    raw_time_number = parseInt($("#operation_op_departure_4i").val())

    # Adjust the raw time number for pst
    if raw_time_number - pst_time() < 0
      pst_time_number = raw_time_number + 24 - pst_time()
    else
      pst_time_number = raw_time_number - pst_time()
    # Adjust the raw time number for cst
    if raw_time_number - cst_time() < 0
      cst_time_number = raw_time_number + 24 - cst_time()
    else
      cst_time_number = raw_time_number - cst_time()
    # Adjust the raw time number for est
    if raw_time_number - est_time() < 0
      est_time_number = raw_time_number + 24 - est_time()
    else
      est_time_number = raw_time_number - est_time()

    # Set the data attribute to the adjusted time number
    $(".op-departure-time .time-preview__pst-container .time").data('time-hour', pst_time_number)
    $(".op-departure-time .time-preview__cst-container .time").data('time-hour', cst_time_number)
    $(".op-departure-time .time-preview__est-container .time").data('time-hour', est_time_number)

    # Convert the time number into a string
    pst_time_string = pst_time_number.toString()
    cst_time_string = cst_time_number.toString()
    est_time_string = est_time_number.toString()

    # Format the time string for display
    if pst_time_string.length < 2
      pst_time_string = "0" + pst_time_string
    if cst_time_string.length < 2
      cst_time_string = "0" + cst_time_string
    if est_time_string.length < 2
      est_time_string = "0" + est_time_string
    pst_op_departure_time = pst_time_string + ":" + $(".op-departure-time .time-preview__pst-container .time").data('time-minute').toString()
    cst_op_departure_time = cst_time_string + ":" + $(".op-departure-time .time-preview__cst-container .time").data('time-minute').toString()
    est_op_departure_time = est_time_string + ":" + $(".op-departure-time .time-preview__est-container .time").data('time-minute').toString()

    # Display the time string
    $(".op-departure-time .time-preview__pst-container .time").text(pst_op_departure_time)
    $(".op-departure-time .time-preview__cst-container .time").text(cst_op_departure_time)
    $(".op-departure-time .time-preview__est-container .time").text(est_op_departure_time)
  )
  # Calculate op departure time in PST, CST and EST
  $("#operation_op_departure_5i").on('change', ->
    # Set the data attributes to the value of the select
    $(".op-departure-time .time-preview__pst-container .time").data('time-minute', $("#operation_op_departure_5i").val())
    $(".op-departure-time .time-preview__cst-container .time").data('time-minute', $("#operation_op_departure_5i").val())
    $(".op-departure-time .time-preview__est-container .time").data('time-minute', $("#operation_op_departure_5i").val())

    # Format the time string for display
    pst_op_departure_time = $(".op-departure-time .time-preview__pst-container .time").data('time-hour').toString() + ":" + $("#operation_op_departure_5i").val()
    cst_op_departure_time = $(".op-departure-time .time-preview__cst-container .time").data('time-hour').toString() + ":" + $("#operation_op_departure_5i").val()
    est_op_departure_time = $(".op-departure-time .time-preview__est-container .time").data('time-hour').toString() + ":" + $("#operation_op_departure_5i").val()

    # Display the time string
    $(".op-departure-time .time-preview__pst-container .time").text(pst_op_departure_time)
    $(".op-departure-time .time-preview__cst-container .time").text(cst_op_departure_time)
    $(".op-departure-time .time-preview__est-container .time").text(est_op_departure_time)
  )

  # Calculate op completion time in PST, CST and EST
  $("#operation_op_completion_4i").on('change', ->
    # Retrieve the raw time number from the select
    raw_time_number = parseInt($("#operation_op_completion_4i").val())

    # Adjust the raw time number for pst
    if raw_time_number - pst_time() < 0
      pst_time_number = raw_time_number + 24 - pst_time()
    else
      pst_time_number = raw_time_number - pst_time()
    # Adjust the raw time number for cst
    if raw_time_number - cst_time() < 0
      cst_time_number = raw_time_number + 24 - cst_time()
    else
      cst_time_number = raw_time_number - cst_time()
    # Adjust the raw time number for est
    if raw_time_number - est_time() < 0
      est_time_number = raw_time_number + 24 - est_time()
    else
      est_time_number = raw_time_number - est_time()

    # Set the data attribute to the adjusted time number
    $(".op-completion-time .time-preview__pst-container .time").data('time-hour', pst_time_number)
    $(".op-completion-time .time-preview__cst-container .time").data('time-hour', cst_time_number)
    $(".op-completion-time .time-preview__est-container .time").data('time-hour', est_time_number)

    # Convert the time number into a string
    pst_time_string = pst_time_number.toString()
    cst_time_string = cst_time_number.toString()
    est_time_string = est_time_number.toString()

    # Format the time string for display
    if pst_time_string.length < 2
      pst_time_string = "0" + pst_time_string
    if cst_time_string.length < 2
      cst_time_string = "0" + cst_time_string
    if est_time_string.length < 2
      est_time_string = "0" + est_time_string
    pst_op_completion_time = pst_time_string + ":" + $(".op-completion-time .time-preview__pst-container .time").data('time-minute').toString()
    cst_op_completion_time = cst_time_string + ":" + $(".op-completion-time .time-preview__cst-container .time").data('time-minute').toString()
    est_op_completion_time = est_time_string + ":" + $(".op-completion-time .time-preview__est-container .time").data('time-minute').toString()

    # Display the time string
    $(".op-completion-time .time-preview__pst-container .time").text(pst_op_completion_time)
    $(".op-completion-time .time-preview__cst-container .time").text(cst_op_completion_time)
    $(".op-completion-time .time-preview__est-container .time").text(est_op_completion_time)
  )
  # Calculate op completion time in PST, CST and EST
  $("#operation_op_completion_5i").on('change', ->
    # Set the data attributes to the value of the select
    $(".op-completion-time .time-preview__pst-container .time").data('time-minute', $("#operation_op_completion_5i").val())
    $(".op-completion-time .time-preview__cst-container .time").data('time-minute', $("#operation_op_completion_5i").val())
    $(".op-completion-time .time-preview__est-container .time").data('time-minute', $("#operation_op_completion_5i").val())

    # Format the time string for display
    pst_op_completion_time = $(".op-completion-time .time-preview__pst-container .time").data('time-hour').toString() + ":" + $("#operation_op_completion_5i").val()
    cst_op_completion_time = $(".op-completion-time .time-preview__cst-container .time").data('time-hour').toString() + ":" + $("#operation_op_completion_5i").val()
    est_op_completion_time = $(".op-completion-time .time-preview__est-container .time").data('time-hour').toString() + ":" + $("#operation_op_completion_5i").val()

    # Display the time string
    $(".op-completion-time .time-preview__pst-container .time").text(pst_op_completion_time)
    $(".op-completion-time .time-preview__cst-container .time").text(cst_op_completion_time)
    $(".op-completion-time .time-preview__est-container .time").text(est_op_completion_time)
  )
