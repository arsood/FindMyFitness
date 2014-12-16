//Execute only when business show page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_show") {

	//Get business map

	$.ajax({
		url: "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyAnfmjbf-Fz9g-6i1q6tBE5GMSHXqwPLpk&address=" + encodeURIComponent($("#business-address").val()),
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

	//Save business to save list

	$(document).on("click", "#business-save-button", function() {
		$.ajax({
			url:"http://localhost:3000/business/save",
			type:"POST",
			data: {
				business_id: $(this).attr("data-business"),
				authenticity_token: $("input[name=authenticity_token]").val()
			},
			success:function() {
				$("#business-save-button").attr("style", "background:#5cb85c;");
			},
			error:function() {
				alert("There was something wrong processing your request.");
			}
		});
	});

	//Change stars selected for business reviews

	$(document).on("click", ".review-star", function() {
		$(".review-star").removeClass("fa-star").addClass("fa-star-o");

		var starNumber = $(this).attr("id").split("review-star-")[1];
		
		for (var i = 1; i <= starNumber; i++) {
			$("#review-star-" + i).removeClass("fa-star-o").addClass("fa-star");
		}

		$("#review-star-value").val(starNumber);
	});

	//Close review modal and remove data

	$(document).on("hidden.bs.modal", "#review-modal", function() {
		$(".review-star").removeClass("fa-star").addClass("fa-star-o");

		$("#review-text").val("");
	});

//Close condition that business show page
} });

$(document).on("click", "#toggle-bus-photos", function() {
	$("#business-info").hide();
	$("#business-reviews").hide();
	$("#business-photos").fadeIn();

	//Run gallery on click

	resizeGalleria();
	Galleria.run('#galleria', {
		wait: true
	});
});

//Only execute when business search page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_search") {

	$.ajax({
		url: "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyAnfmjbf-Fz9g-6i1q6tBE5GMSHXqwPLpk&address=" + encodeURIComponent($("#location-address").val()),
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

//Close condition that business search page
} });

//Execute only when business signup page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_signup") {

	//Initiate Dropzone for new business

	$(document).ready(function() {
		if ($("#drop-area").length) {
			$("div#drop-area").dropzone({
				url: "/business/images",
				params: {
					authenticity_token: $("input[name='authenticity_token']").val(),
					business_hash: $("input[name='business[business_hash]']").val()
				},
				addRemoveLinks: true
			});
		}
	});

//Close condition that has to be business signup
} });