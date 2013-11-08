$(function() {
  $("time").cuteTime();
  $("a.activate-deployment").click(function(event) {
    event.preventDefault();
    $("div#info").html("<img src='/deployments/images/spinner.gif'/> <strong>Activating deployment "+$(this).attr("id")+" deployment</strong>. The page will reload automatically when the activation is finished.").show();
    $.post("/deployments/"+$(this).attr('id')+"/activate", function(data) {
      console.log(data);
      $("div#info").hide();
      location.reload();
    });
  })
});
