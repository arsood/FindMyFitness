//Condition that has to be new blog post page
$(document).ready(function() {
if ($("#page_id").length && ($("#page_id").val() === "new_blog_post" || $("#page_id").val() === "edit_blog_post")) {

	//Initiate Dropzone for events

	if ($("#drop-area").length) {
		$("div#drop-area").dropzone({
			url: "/blog/images",
			params: {
				authenticity_token: $("input[name='authenticity_token']").val(),
				blog_post_id: $("input[name='post[post_id]']").val()
			},
			addRemoveLinks: true
		});
	}

//Close condition that has to be new blog post page
} });

//Condition that has to be edit blog post page
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "edit_blog_post") {

	//Handle photo delete

	$(document).on("click", ".profile-photos-container i", function(event) {
		event.preventDefault();
		
		var deleteConfirm = confirm("Are you sure you want to delete this photo?");

		if (deleteConfirm) {
			var photoId = $(this).attr("data-id");
			var authToken = $("input[name=authenticity_token]").val();

			$.ajax({
				url: "/post/images/delete",
				type: "POST",
				data: {
					image_id: photoId,
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

//Close condition that has to be edit blog post page
} });

//Condition that has to be post show page
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "show_post") {

	//Initialize Galleria for post images

	if ($("#galleria").length) {
		resizeGalleria();

		Galleria.run('#galleria', {
			wait: true
		});
	}

//Close condition that has to be post show page
} });

function resizeBlockImages() {
	$(".responsive-block-image").css("height", $(".responsive-block-image").width());
}

$(window).resize(function() {
	resizeBlockImages();
});

resizeBlockImages();

//Like a post

$(document).on("click", ".blog-like-button", function(event) {
	event.preventDefault();

	if ($(this).hasClass("post-liked")) {
		return false;
	} else {
		var that = this;

		$.ajax({
			url: "/post/like",
			type: "POST",
			data: {
				authenticity_token: $("input[name='authenticity_token']").val(),
				post_id: $(this).attr("data-id")
			},
			success: function(data) {
				if (data.result === "ok") {
					$(that).addClass("post-liked");
				}
			}
		});
	}
});

//Process click for following a user

$(document).on("click", "#follow-user-link", function(event) {
	event.preventDefault();

	var that = this;

	$.ajax({
		url: "/followers/add",
		type: "POST",
		data: {
			owner_id: $(this).attr("data-id"),
			authenticity_token: $("input[name=authenticity_token]").val()
		},
		success: function(data) {
			if (data.result === "ok") {
				if (data.state === "added") {
					$("#follow-confirm-title").html("You are now following this user");
					$("#follow-confirm-text").html("Success! You are now following this user.");
					$("#follow-user-link").html("Unfollow " + $(that).attr("data-name"));
					$("#follow-confirm-modal").modal("show");
				} else {
					$("#follow-confirm-title").html("You are now unsubscribed");
					$("#follow-confirm-text").html("You are now unsubscribed from this user.");
					$("#follow-user-link").html("Follow " + $(that).attr("data-name"));
					$("#follow-confirm-modal").modal("show");
				}
			}
		},
		error: function() {
			alert("There was an error processing your request.");
		}
	});
});