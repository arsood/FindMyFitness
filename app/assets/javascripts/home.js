//Homepage JS
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "homepage") {

//Resize homepage carousel

function resizeHomeCarousel() {
	var headerHeight = $(".fmf-navbar").height();

	$("#homepage-carousel .carousel-inner").height(
		$(window).height() - headerHeight
	);
}

resizeHomeCarousel();

//Handle sizing of homepage cards

function resizeHomeCards() {
	var cards = $(".home-card");

	var cardHeights = [];

	$.each(cards, function(index, card) {
		cardHeights.push(card.clientHeight);
	});

	var maxCard = Math.max.apply(null, cardHeights);
	var realHeight = maxCard * 2;

	$(".home-card-image").height(maxCard + 100);
	$(".home-card").height(realHeight + 100);
}

resizeHomeCards();

//Apply functions to window resize

$(window).resize(function() {
	resizeHomeCarousel();
});

//Close condition that has to be homepage
} });