setInterval(->
  $.ajax
    url: "/tmsis"
    success: (res) ->
      $("#numbers li").remove()
      for number in res.split '\n'
        if number.length > 1
            $("#numbers").append "<li> #{number}"
, 10 * 1000)