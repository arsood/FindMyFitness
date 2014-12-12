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

//Change background color of left sidebar menu items

$(document).on("click", ".left-sidebar-menu a", function(event) {
	event.preventDefault();
	
	$(".left-sidebar-menu a").removeClass("active");
	$(this).addClass("active");
});

//Toggle login form show

$(document).on("click", "#login-toggle-button", function(event) {
	event.preventDefault();
	event.stopPropagation();

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