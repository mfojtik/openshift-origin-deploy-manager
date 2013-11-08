$(function() {
  $("time").cuteTime();
  $("a.activate-deployment").click(function(event) {
    event.preventDefault();
    $("div#info").html("Activating "+$(this).attr("id")+" deployment...").show();
    $.post("/deployments/"+$(this).attr('id')+"/activate", function(data) {
      console.log(data);
      $("div#info").hide();
    });
  })
});
