//Remove an item

function deleteItem(scope, confirmDelete, type, reload) {
	if (confirmDelete) {
		$.ajax({
			url: "/admin/delete",
			type: "POST",
			data: {
				type: type,
				id: $(scope).attr("data-id"),
				authenticity_token: $("input[name=authenticity_token]").val()
			},
			success: function(data) {
				if (data.result === "ok") {
					if (reload) {
						window.location.reload();
					} else {
						window.location.href="/admin";
					}
				} else {
					alert(data.error);
				}
			},
			error: function() {
				alert("There was an error processing the delete.");
			}
		});
	} else {
		return false;
	}
}

//Handle AJAX for deletes across the whole site

$(document).on("click", "#super-user-delete-event", function(event) {
	event.preventDefault();

	var confirmDelete = confirm("Are you sure you want to delete this event? This cannot be undone.");

	deleteItem(this, confirmDelete, "event", false);
});

$(document).on("click", "#super-user-delete-post", function(event) {
	event.preventDefault();

	var confirmDelete = confirm("Are you sure you want to delete this post? This cannot be undone.");

	deleteItem(this, confirmDelete, "post", false);
});

$(document).on("click", "#super-user-delete-business", function(event) {
	event.preventDefault();

	var confirmDelete = confirm("Are you sure you want to delete this business? This cannot be undone.");

	deleteItem(this, confirmDelete, "business", false);
});

$(document).on("click", "#super-user-delete-review", function(event) {
	event.preventDefault();

	var confirmDelete = confirm("Are you sure you want to delete this review? This cannot be undone.");

	deleteItem(this, confirmDelete, "review", true);
});

//Open condition that has to be fmf photo admin page
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "fmf_admin_photos") {

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
		var authToken = $("input[name=authenticity_token]").val();

		$.ajax({
			url: "/admin/photos/delete",
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

//Close condition that has to be fmf photo admin
} });
