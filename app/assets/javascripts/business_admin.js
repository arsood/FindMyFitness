//Execute only when business analytics page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_analytics") {

var newDate = new Date()
var timeOff = newDate.getTimezoneOffset();

function getAnalyticsChart(type) {
	$.ajax({
		type: "POST",
		url: "http://localhost:3000/business-admin/analytics/get-views",
		data: {
			business_id: $("#business_id").val(),
			authenticity_token: $("input[name=authenticity_token]").val(),
			type: type,
			time_offset: timeOff
		},
		success: function(data) {
			if (data.labels.length <= 1) {
				$("#chart-container").html("<div class='medium-title'>Not enough data to show anything.</div>");
			} else {
				//Reset canvas on every call
				$("#chart-container").html("<canvas id='views-chart' height='400'></canvas>");

				var containerWidth = $("#chart-container").width();
				$("#views-chart").attr("width", containerWidth);

				var ctx = document.getElementById("views-chart").getContext("2d");

				var viewsChart = new Chart(ctx).Line(data);
			}
		},
		error: function() {
			alert("There was an error retrieving the data.");
		}
	});
}

getAnalyticsChart("24hour");

//Change analytics type on button click

$(document).on("click", "#analytics-24-hour", function() {
	getAnalyticsChart("24hour");
});

$(document).on("click", "#analytics-month", function() {
	getAnalyticsChart("month");
});

$(document).on("click", "#analytics-year", function() {
	getAnalyticsChart("year");
});

//Close condition that has to be business analytics
} });

//Execute only when business admin index page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_admin_index") {

$(document).on("mouseenter", ".admin-select-business", function() {
	$(this).find(".admin-select-business-label").slideDown();
});

$(document).on("mouseleave", ".admin-select-business", function() {
	$(this).find(".admin-select-business-label").slideUp();
});

$(document).on("click", ".admin-select-business", function() {
	window.location.href = "/business-admin/edit/" + $(this).attr("data-id");
});

//Close condition that has to be business admin index
} });

//Execute only when business admin photos page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_photos") {

//Change class for business photo edit buttons

$(document).on("click", "#profile-edit-on", function(event) {
	event.preventDefault();

	$("#profile-edit-off").removeClass("btn-primary").addClass("btn-default");
	$(this).addClass("btn-primary");
	$(".profile-photos-container i").removeClass("hide");
});

$(document).on("click", "#profile-edit-off", function(event) {
	event.preventDefault();

	$("#profile-edit-on").removeClass("btn-primary").addClass("btn-default");
	$(this).addClass("btn-primary");
	$(".profile-photos-container i").addClass("hide");
});

//Handle photo delete

$(document).on("click", ".profile-photos-container i", function(event) {
	event.preventDefault();
	
	var deleteConfirm = confirm("Are you sure you want to delete this photo?");

	if (deleteConfirm) {
		var photoId = $(this).attr("data-id");
		var authToken = $("input[name=authenticity_token]").val();

		$.ajax({
			url: "/business-admin/photos/" + $("#business_id").val() + "/delete",
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

//Close condition that has to be business admin photos
} });