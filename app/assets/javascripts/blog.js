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

//Close condition that has to be post show page
} });
