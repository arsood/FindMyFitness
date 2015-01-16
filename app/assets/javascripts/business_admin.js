//Execute only when business analytics page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_analytics") {

var newDate = new Date()
var timeOff = newDate.getTimezoneOffset();

function get24Hour() {
	$.ajax({
		type: "POST",
		url: "http://localhost:3000/business-admin/analytics/get-views",
		data: {
			business_id: $("#business_id").val(),
			authenticity_token: $("input[name=authenticity_token]").val(),
			type: "24hour",
			time_offset: timeOff
		},
		success: function(data) {
			var containerWidth = $("#chart-container").width();
			$("#views-chart").attr("width", containerWidth);

			var ctx = document.getElementById("views-chart").getContext("2d");

			var viewsChart = new Chart(ctx).Line(data);
		},
		error: function() {
			alert("There was an error retrieving the data.");
		}
	});
}

get24Hour();

//Close condition that has to be business analytics
} });