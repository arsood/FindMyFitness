Galleria.loadTheme('/assets/themes/classic/galleria.classic.min.js');

function resizeGalleria() {
	var galleriaWidth = $("#galleria").width();
	var newGalleriaHeight = galleriaWidth * 0.725;
	
	$("#galleria").css("height",newGalleriaHeight);
}

$(window).on("resize", function() {
	resizeGalleria();
});