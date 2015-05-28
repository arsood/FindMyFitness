//Execute only when events page is shown

$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "events") {

//Change search based on category

$(document).on("click", ".left-sidebar-menu a", function(event) {
	event.preventDefault();
	
	$(".left-sidebar-menu a").removeClass("active");
	$(this).addClass("active");

	if ($(this).attr("data-category") === "All") {
		window.location.href="/events";
	} else {
		window.location.href = "/events?category=" + encodeURIComponent($(this).attr("data-category"));
	}
});

//Initialize full calendar

$(document).ready(function() {
	$.ajax({
		type: "GET",
		url: "/event/all",
		success: function(eventData) {
			$("#event-calendar").fullCalendar({
				header: {
					left:"prev",
					center:"title",
					right:"next"
				},
				dayClick: function(date, jsEvent, view) {
					$(".fc-day").css("background-color", "");
					$(this).css("background-color", "#E6F0F7");
				},
				events: eventData,
				eventClick: function(calEvent) {
					window.location.href = "/events/" + calEvent.id;
				}
			});
		},
		error: function() {
			alert("There was a problem retrieving the data.");
		}
	});
});

//Hide and show calendar

$(document).on("click", "#hide-calendar-button", function(event) {
	event.preventDefault();

	if ($("#event-calendar").is(":visible")) {
		$("#event-calendar").slideUp();
		$(this).html("Show Calendar");
	} else {
		$("#event-calendar").slideDown();
		$(this).html("Hide Calendar");
	}
});

//Close condition that page is events
} });

//Condition that has to be new or edit event page
$(document).ready(function() {
if ($("#page_id").length && ($("#page_id").val() === "new_event" || $("#page_id").val() === "edit_event")) {

	//Initiate Dropzone for events

	$(document).ready(function() {
		if ($("#drop-area").length) {
			$("div#drop-area").dropzone({
				url: "/event/images",
				params: {
					authenticity_token: $("input[name='authenticity_token']").val(),
					event_id: $("input[name='event[event_id]']").val()
				},
				addRemoveLinks: true
			});
		}
	});

//Close condition that has to be new or edit event page
} });

//Condition that has to be edit event page
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "edit_event") {

	//Handle photo delete

	$(document).on("click", ".profile-photos-container i", function(event) {
		event.preventDefault();
		
		var deleteConfirm = confirm("Are you sure you want to delete this photo?");

		if (deleteConfirm) {
			var photoId = $(this).attr("data-id");
			var authToken = $("input[name=authenticity_token]").val();

			$.ajax({
				url: "/event/images/delete",
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

//End condition that has to be event edit page
} });

//Only execute this when event show page is active
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "event_show") {

//Initialize Galleria

if ($("#galleria").length) {
	resizeGalleria();

	Galleria.run('#galleria', {
		wait: true
	});
}

$.ajax({
	url: "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyAnfmjbf-Fz9g-6i1q6tBE5GMSHXqwPLpk&address=" + encodeURIComponent($("#event-location").val()),
	type: "GET",
	success: function(data) {
		initializeMap(
			data.results[0].geometry.location.lat,
			data.results[0].geometry.location.lng
		);
	},
	error: function() {
		alert("Something went wrong getting maps information.");
	}
});

function initializeMap(lat, lng) {
	var myLatlng = new google.maps.LatLng(lat, lng);
	
	var mapOptions = {
		zoom: 15,
		center: myLatlng
	}

	var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

	var marker = new google.maps.Marker({
		position: myLatlng,
		map: map
	});
}

$(document).on("click", "#event-get-directions", function() {
	window.open("https://google.com/maps/search/" + encodeURIComponent($("#event-location").val()));
});

$(document).on("click", "#event-save-button", function() {
	var authToken = $("input[name=authenticity_token]").val();

	$.ajax({
		url: "/events/save",
		type: "POST",
		data: {
			event_id: $(this).attr("data-id"),
			authenticity_token: authToken
		},
		success: function(data) {
			if (data.action === "save") {
				$("#event-save-button").addClass("save-success");
				$("#event-save-success-modal").modal("show");
			} else {
				$("#event-save-button").removeClass("save-success");
				$("#event-unsave-success-modal").modal("show");
			}
		},
		error: function() {
			alert("There was an error processing the save. Please try again.");
		}
	});
});

//Close document ready and event page condition
} });