$(function() {
  $("time").cuteTime();
  $("a.activate-deployment").click(function(event) {
    event.preventDefault();
    $.post("/deployments/"+$(this).attr('id')+"/activate", function(data) {
      console.log(data);
    });
  })
});
