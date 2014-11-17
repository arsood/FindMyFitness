//Execute only when business show page is shown

$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_show") {

//Get business map

$.ajax({
	url: "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyD0JurFAyESl2TlZc2rDMHRIFDKGYMmvqY&address=" + encodeURIComponent($("#business-address").val()),
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

$(document).on("click", "#business-get-directions", function() {
	window.open("https://google.com/maps/search/" + encodeURIComponent($("#business-address").val()));
});

//Close condition that business show page

} });