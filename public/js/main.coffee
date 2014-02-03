setInterval(->
  $.ajax
    url: "/numbers"
    success: (res) ->
      $(".number").remove()
      for number in res.split '\n'
        if number.length > 0
          [num,imsi] = number?.split "'"
          if num.length is 7
            num = num[...3]+'-'+num[3...]
          if num.length is 10
            num = num[...3]+'-'+num[3...6]+'-'+num[6...]

          $("#numbers").append "<tr class=number><td class=num>#{num}</td><td class=imsi>#{imsi[4...]}</td></tr>"
      $.ajax
        url: "/tmsis"
        success: (res) ->
          for imsi in res.split '\n'
            if imsi.length > 1
                $("#IMSI"+imsi).addClass 'active'
, 10 * 1000)

$(document).ready ->
  map = L.map("map").setView([40.660584, -73.986096], 13)
  L.tileLayer("http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png",
    maxZoom: 18
    attribution: "Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"http://cloudmade.com\">CloudMade</a>"
  ).addTo(map)

  popup = L.popup()

  map.on "click", (e) ->
    lat = e.latlng.lat.toFixed(4)
    lng = e.latlng.lng.toFixed(4)
    latlng = "(#{lat},#{lng})"
    $('#latlng').val(latlng)
    
    popup
      .setLatLng e.latlng
      .setContent "Added #{latlng} to message"
      .openOn map