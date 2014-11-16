// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//Initiate Dropzone for events

if ($("#drop-area").length) {
	$("div#drop-area").dropzone({
		url: "images",
		params: {
			authenticity_token: $("input[name='authenticity_token']").val(),
			event_id: $("input[name='event[event_id]']").val()
		},
		addRemoveLinks: true
	});
}

$(document).ready(function() {
	if ($("#event-save-button").length) {
		resizeGalleria();

		Galleria.run('#galleria', {
			wait: true
		});
	} else {
		return false;
	}
});
