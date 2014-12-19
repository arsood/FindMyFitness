//Initialize all tooltips

$(function () {
	$('[data-toggle="tooltip"]').tooltip();
});

//Handle business page menu toggling

$(document).on("click", ".gray-menu-item.clickable", function() {
	$(".gray-menu-item").removeClass("gray-menu-item-active");
	$(this).addClass("gray-menu-item-active");
});

//Toggle business views

$(document).on("click", "#toggle-bus-info", function() {
	$("#business-info").fadeIn();
	$("#business-reviews").hide();
	$("#business-photos").hide();
});

$(document).on("click", "#toggle-bus-reviews", function() {
	$("#business-info").hide();
	$("#business-reviews").fadeIn();
	$("#business-photos").hide();
});

//Toggle login form show

$(document).on("click", "#login-toggle-button", function(event) {
	event.preventDefault();

	$("input[name='username']").val("");
	$("input[name='password']").val("");
	$("#login-top-menu").fadeToggle(100);
});

//Toggle options menu show

$(document).on("click", "#options-menu-toggle", function(event) {
	event.preventDefault();

	$("#options-top-menu").fadeToggle(100);
});

//Toggle signup window show

$(document).on("click", "#signup-toggle-button", function(event) {
	event.preventDefault();
	event.stopPropagation();

	$("#login-top-menu").fadeOut(100);
	$("#signup-modal").modal("show");
});

//Click on nav menu categories

$(document).on("click", "#bus-category-top-options div a", function(event) {
	event.preventDefault();

	var newCat = encodeURIComponent($(this).html());

	location.href = "/businesses/find?category=" + newCat;
});

//Change avatar on click

$(document).on("click", "#sidebar-new-avatar", function() {
	$("#new-avatar").trigger("click");
});

$(document).on("change", "#new-avatar", function() {
	$(".ajax-cover").fadeIn(600);

	var uploadField = document.getElementById("new-avatar");
	var file = uploadField.files;

	var avatarForm = new FormData();

	avatarForm.append("file", file[0]);
	avatarForm.append("authenticity_token", $("input[name=authenticity_token]").val());

	$.ajax({
		url: "http://localhost:3000/profile/upload",
		type: "POST",
		processData: false,
		contentType: false,
		data: avatarForm,
		success: function(data) {
			$("#sidebar-new-avatar").attr("src", data.photo);
			$("#header-dropdown-avatar").attr("src", data.photo);
			$(".ajax-cover").fadeOut(600);
		},
		error: function() {
			alert("There was an error processing your request.");
			$(".ajax-cover").fadeOut(600);
		}
	});
});