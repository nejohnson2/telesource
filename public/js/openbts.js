$(document).ready(function() {

    console.log("*** Document Ready ***");

    $.get('/cellid', $(this).serialize(), function(d){
      console.log("Cellid - " + d);
      $("#cellid").append("<p>" + d + "</p>");
    });
    
    $(this).find('input').val('');
    /******  This is to show how many characters have been typed  ******/
    var keyHandler = function (e) {
        var len = this.value.length;
        var left = 140 - len;
        if (left < 10) left = "&nbsp;&nbsp;"+left;
        // pad to keep the width the same, total hack
        
        $("#num").text(left);
        
        var anyEmpty = $("input").is(function () {
          return this.value.length === 0;
        })
        
        if (!anyEmpty) {
          $("button").addClass("complete");
        } else {
          $("button").removeClass("complete");
        }
    };
    $("input").keydown(keyHandler);
    $("input").keypress(keyHandler);
    $("input").keyup(keyHandler);   
});

$("#form").submit(function (e) {
    console.log("**** Form has been submitted *****");
    e.preventDefault();

    $.get('/input', $(this).serialize(), function(d){
       console.log("*** Making GET request to \"/input\" ***");
    });
});

$("input").keypress(function(event) {
    if (event.which == 13) {
        event.preventDefault();
        $("form").submit();
        $("form")[0].reset();
    }
});