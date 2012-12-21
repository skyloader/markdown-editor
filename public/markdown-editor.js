$(document).ready(function() {
  $("#editor-apply").click(function() {
    var markdown = $("#editor-markdown").val();
    $.post(
      "/convert", 
      { "markdown" : markdown }, 
      function(data) {
        $("#editor-html").html(data.html);
      },
      "json"
    );
  });

  $("#editor-markdown").keyup(function(e) {
    //alert(e.keycoode);
    if (e.keyCode == 13) {
      var markdown = $("#editor-markdown").val();
      $.post(
        "/convert", 
        { "markdown" : markdown }, 
        function(data) {
          $("#editor-html").html(data.html);
        },
        "json"
      );
    };
  });
  $(function(){ 
    $("#editor-layout").equalHeights();
  });
});


$(function () {
  $('#fileupload').fileupload({
    dataType: 'json',
    url: '/convert',
    done: function (e, data) {
      var result = data.result;
    }
  });
});
