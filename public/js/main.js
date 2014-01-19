var interval = setInterval(function(){
  jQuery.ajax({
      url: '/tmsis'
    , success: function (res) {
        $('#numbers li').remove();
        _ref = res.split("\n");
        if(_ref.length != 0) {
           for (_i = 0, _len = _ref.length; _i < _len; _i++) {
             number = _ref[_i];
             $('#numbers').append("<li>IMSI: " + number + "</li>");
           }
           /*for (_i = 0,_i < _ref.length; _i++) {
             number = _ref[_i];
             $('#numbers').append("<li>IMSI: " + number + "</li>");
           }*/
        }
    }
  })
}, 10*1000);