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

$(document).on("click", "#toggle-bus-photos", function() {
	$("#business-info").hide();
	$("#business-reviews").hide();
	$("#business-photos").fadeIn();

	//Run gallery on click

	resizeGalleria();
	Galleria.run('#galleria');
});

//Change background color of left sidebar menu items

$(document).on("click", ".left-sidebar-menu a", function(event) {
	event.preventDefault();
	
	$(".left-sidebar-menu a").removeClass("active");
	$(this).addClass("active");
});

//Change class for profile edit buttons

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
	$(".profile-photos-container i ").addClass("hide");
});

//Save business to save list