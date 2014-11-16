// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//Initiate Dropzone for events

$("div#drop-area").dropzone({
	url: "images",
	params: {
		authenticity_token: $("input[name='authenticity_token']").val(),
		event_id: $("input[name='event[event_id]']").val()
	},
	addRemoveLinks: true
});

$(document).ready(function() {
	resizeGalleria();
	Galleria.run('#galleria');
});
