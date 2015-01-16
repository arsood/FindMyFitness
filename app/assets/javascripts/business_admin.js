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