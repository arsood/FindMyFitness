Galleria.loadTheme('libraries/galleria-1.4.2/themes/classic/galleria.classic.min.js');
Galleria.run('#galleria');

function resizeGalleria() {
	var galleriaWidth = $("#galleria").width();
	var newGalleriaHeight = galleriaWidth * 0.725;
	
	$("#galleria").css("height",newGalleriaHeight);
}

resizeGalleria();

$(window).on("resize", function() {
	resizeGalleria();
});