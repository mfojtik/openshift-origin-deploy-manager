$(function() {
  $("time").cuteTime();
  $("a.activate-deployment").click(function(event) {
    event.preventDefault();
    $.post("/deployments/"+$(self).attr('id')+"/activate", function(data) {
      console.log(data);
    });
  })
});
