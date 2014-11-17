$(".datepicker").datepicker(
  { dateFormat: "mm-dd-yy"}
);

$(".datepicker").on("change", function () {
    var id = $(this).attr("id");
    var val = $("label[for='" + id + "']").text();
    $("#msg").text(val + " changed");
});


$(".dislike-user").on("click", function(){
  $(this).closest(".col-md-3").addClass("hide");
});

$(".like-button").on("click", function(){
  $(this).val("Liked");
});