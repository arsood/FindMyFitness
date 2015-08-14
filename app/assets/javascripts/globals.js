var environment = "production";

if (environment === "test") {
	var endpointBase = "http://localhost:3000/";
} else {
	var endpointBase = "http://findmyfitness.com/";
}

//Report photos throughout the site

$(document).on("click", ".report-photos-button", function(event) {
	event.preventDefault();

	$("#spam-photos-confirm-button").attr("data-hash", $(this).attr("data-hash")).attr("data-type", $(this).attr("data-type"));

	$("#spam-photos-confirm-modal").modal("show");
});

$(document).on("click", "#spam-photos-confirm-button", function(event) {
	event.preventDefault();

	$("#spam-photos-confirm-button").attr("disabled", "disabled");

	var photo_hash = $(this).attr("data-hash");
	var photo_type = $(this).attr("data-type");

	$.ajax({
		url: "/report/photos",
		type: "POST",
		data: {
			photo_hash: photo_hash,
			photo_type: photo_type,
			authenticity_token: $("input[name='authenticity_token']").val()
		},
		success: function() {
			$("#spam-photos-confirm-modal").modal("hide");
			$("#spam-photos-confirm-button").removeAttr("disabled");
		},
		error: function() {
			alert("There was a problem. Please try again.");
			$("#spam-photos-confirm-button").removeAttr("disabled");
		}
	});
});

$(document).on("click", "#reload-page", function() {
	window.location.reload();
});