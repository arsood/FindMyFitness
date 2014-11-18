// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

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
