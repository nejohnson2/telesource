setInterval(->
  $.ajax
    url: "/numbers"
    success: (res) ->
      $("#numbers li").remove()
      for number in res.split '\n'
        if number?.length > 1
            [num,imsi] = number?.split "'"
            $("#numbers").append "<li id=#{imsi}> #{num}"
      $.ajax
        url: "/tmsis"
        success: (res) ->
          for imsi in res.split '\n'
            if imsi.length > 1
                $("#IMSI"+imsi).addClass 'active'
, 10 * 1000)