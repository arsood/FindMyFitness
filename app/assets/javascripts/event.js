//Only execute this when event page is active

$(document).ready(function() {
if ($("#event-save-button").length) {

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

//Initialize Galleria

resizeGalleria();

Galleria.run('#galleria', {
	wait: true
});

$.ajax({
	url: "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyD0JurFAyESl2TlZc2rDMHRIFDKGYMmvqY&address=" + $("#event-location").val(),
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
		map: map,
		title: 'Hello World!'
	});
}

//Close document ready and event page condition

} });
