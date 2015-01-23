//Condition that has to be new blog post page
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "new_blog_post") {

	//Initiate Dropzone for events

	if ($("#drop-area").length) {
		$("div#drop-area").dropzone({
			url: "images",
			params: {
				authenticity_token: $("input[name='authenticity_token']").val(),
				blog_post_id: $("input[name='post[post_id]']").val()
			},
			addRemoveLinks: true
		});
	}

//Close condition that has to be new blog post page
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
						$("#follow-confirm-text").html("Success! You are now following this user's blog posts.");
						$("#follow-user-link").html("Unfollow " + $(that).attr("data-name"));
						$("#follow-confirm-modal").modal("show");
					} else {
						$("#follow-confirm-title").html("You are now unsubscribed");
						$("#follow-confirm-text").html("You are now unsubscribed from this user's posts.");
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

//Close condition that has to be post show page
} });
