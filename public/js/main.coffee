setInterval(->
  $.ajax
    url: "/tmsis"
    success: (res) ->
      $("#numbers li").remove()
      for number in res.split '\n'
        $("#numbers").append "<li>IMSI: " + number + "</li>"
, 10 * 1000)