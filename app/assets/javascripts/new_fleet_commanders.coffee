jQuery ->
  # http://www.sitepoint.com/call-javascript-function-string-without-using-eval/
  # Opted to use a switch because window access is apparently outside the available namespaces.
  $("#Killboard_Link").on('change', ->
    killboard_url = $("#Killboard_Link").val()
    killboard = detect_killboard(killboard_url)

    switch (killboard)
      when "zkillboard" then zkillboard(killboard_url)
      else console.log("Killboard not known")
  )

  detect_killboard = (url) ->
    new URL(url).hostname.split(".")[0]

  zkillboard = (url) ->
    # Extract the killID from the URL and build the API URL
    url_components = url.split("/")
    kill_id = url_components[url_components.length-2]
    target_url = "https://zkillboard.com/api/killID/#{kill_id}"
    $.ajax({
      dataType: "json",
      url: target_url,
      success: (data) ->
        console.log(data)
        #if data[0] is true
        #  redirect_to_api_list(share_user_id)
        #else
        #  remove_main_button(character_id)
        #  display_alert(data)
    })
