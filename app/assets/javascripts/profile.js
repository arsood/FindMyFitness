// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "profile_photos") {

//Go to the various URLs for different photo categories

$(document).on("change", "#profile-photo-cat-select", function() {
	window.location.href = "?cat=" + $(this).val();
});

//Change class for profile edit buttons

$(document).on("click", "#profile-edit-on", function(event) {
	event.preventDefault();

	$("#profile-edit-off").removeClass("btn-primary").addClass("btn-default");
	$(this).addClass("btn-primary");
	$(".profile-photos-container i").removeClass("hide");
});

$(document).on("click", "#profile-edit-off", function(event) {
	event.preventDefault();

	$("#profile-edit-on").removeClass("btn-primary").addClass("btn-default");
	$(this).addClass("btn-primary");
	$(".profile-photos-container i").addClass("hide");
});

//Handle photo delete

$(document).on("click", ".profile-photos-container i", function(event) {
	event.preventDefault();
	
	var deleteConfirm = confirm("Are you sure you want to delete this photo?");

	if (deleteConfirm) {
		var photoId = $(this).attr("data-id");
		var imageType = $(this).attr("data-type");
		var authToken = $("#photo-form input[name=authenticity_token]").val();

		$.ajax({
			url: "/profile/photos/delete",
			type: "POST",
			data: {
				image_id: photoId,
				image_type: imageType,
				authenticity_token: authToken
			},
			success: function(data) {
				if (data["result"] === "ok") {
					$("#photo" + photoId).fadeOut();
				} else {
					alert("There was a problem deleting this photo.");
				}
			},
			error: function() {
				alert("There was a problem deleting this photo.");
			}
		});
	} else {
		return false;
	}
});

//End condition that page is profile photos page
} });