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