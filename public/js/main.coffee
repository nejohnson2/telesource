setInterval(->
  $.ajax
    url: "/numbers"
    success: (res) ->
      $("#numbers li").remove()
      for number in res.split '\n'
        if number.length > 0
          [num,imsi] = number?.split "'"
          if num.length is 7
            num = num[...3]+'-'+num[3...]
          if num.length is 10
            num = num[...3]+'-'+num[3...6]+'-'+num[6...]

          $("#numbers").append "<li id=#{imsi}> #{num} (#{imsi[4...]})"
      $.ajax
        url: "/tmsis"
        success: (res) ->
          for imsi in res.split '\n'
            if imsi.length > 1
                $("#IMSI"+imsi).addClass 'active'
, 10 * 1000)

		