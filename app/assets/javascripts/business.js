//Execute only when business show page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_show") {

	//Report review as spam
	$(document).on("click", ".business-review-report-spam", function(event) {
		event.preventDefault();

		$("#spam-confirm-button").attr("data-id", $(this).attr("data-id"));
		$("#spam-confirm-modal").modal("show");
	});

	$(document).on("click", "#spam-confirm-button", function(event) {
		event.preventDefault();

		$("#spam-confirm-button").attr("disabled", "disabled");

		$.ajax({
			url: "/report/review",
			type: "POST",
			data: {
				review_id: $(this).attr("data-id"),
				authenticity_token: $("input[name='authenticity_token']").val()
			},
			success: function() {
				$("#spam-confirm-modal").modal("hide");
				$("#spam-confirm-button").removeAttr("disabled");
			},
			error: function() {
				alert("Something went wrong. Please try again.");
				$("#spam-confirm-button").removeAttr("disabled");
			}
		});
	});

	$(document).on("click", "#business-get-directions", function() {
		window.open("https://google.com/maps/search/" + encodeURIComponent($("#business-address").val()));
	});

	//Save business to save list

	$(document).on("click", "#business-save-button", function() {
		if ($(this).hasClass("business-saved")) {
			var removeSaveConf = confirm("Are you sure you want to remove this business from your save list?");

			if (!removeSaveConf) {
				return false;
			}
		}

		$.ajax({
			url:"/business/save",
			type:"POST",
			data: {
				business_id: $(this).attr("data-business"),
				authenticity_token: $("input[name=authenticity_token]").val()
			},
			success:function(data) {
				if (data.result === "ok") {
					$("#business-save-button").addClass("save-success");
					$("#save-success-modal").modal("show");
				} else {
					$("#business-save-button").removeClass("business-saved");
				}
			},
			error:function() {
				alert("There was something wrong processing your request.");
			}
		});
	});

	//Change stars selected for business reviews

	$(document).on("click", ".review-star", function() {
		$(".review-star").removeClass("fa-star").addClass("fa-star-o");

		var starNumber = $(this).attr("id").split("review-star-")[1];
		
		for (var i = 1; i <= starNumber; i++) {
			$("#review-star-" + i).removeClass("fa-star-o").addClass("fa-star");
		}

		$("#review-star-value").val(starNumber);
	});

	//Close review modal and remove data

	$(document).on("hidden.bs.modal", "#review-modal", function() {
		$(".review-star").removeClass("fa-star").addClass("fa-star-o");

		$("#review-text").val("");
	});

	//Initiate Dropzone for reviews

	$(document).ready(function() {
		if ($("#drop-area").length) {
			$("div#drop-area").dropzone({
				url: "/review/images",
				params: {
					authenticity_token: $("input[name='authenticity_token']").val(),
					review_hash: $("input[name='review_hash']").val()
				},
				addRemoveLinks: true
			});
		}
	});

	//Initiate Dropzone for business photos

	$(document).ready(function() {
		if ($("#drop-area-business").length) {
			$("div#drop-area-business").dropzone({
				url: "/business/images",
				params: {
					authenticity_token: $("input[name='authenticity_token']").val(),
					business_hash: $("input[name='business_hash']").val()
				},
				addRemoveLinks: true
			});
		}
	});

	$(document).ready(function() {
		$(".fancybox").fancybox();
	});

//Close condition that business show page
} });

$(document).on("click", "#toggle-bus-photos", function() {
	$("#business-info").hide();
	$("#business-reviews").hide();
	$("#business-photos").fadeIn();

	//Run gallery on click

	if ($("#galleria").length) {
		resizeGalleria();
		Galleria.run('#galleria', {
			wait: true
		});
	}
});

//Only execute when business search page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_search") {



//Close condition that business search page
} });

//Execute only when business signup page is shown
$(document).ready(function() {
if ($("#page_id").length && ($("#page_id").val() === "business_signup" || $("#page_id").val() === "business_photos")) {

	//Initiate Dropzone for new business

	$(document).ready(function() {
		if ($("#drop-area").length) {
			$("div#drop-area").dropzone({
				url: "/business/images",
				params: {
					authenticity_token: $("input[name='authenticity_token']").val(),
					business_hash: $("input[name='business[business_hash]']").val()
				},
				addRemoveLinks: true
			});
		}
	});

//Close condition that has to be business signup
} });

//Execute only when business learn page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "business_learn") {

function resizeLearnBanner() {
	var navbarHeight = $(".fmf-navbar").height();
	var windowHeight = $(window).height();

	$("#business-learn-banner").height(windowHeight - navbarHeight);
}

$(window).resize(function() {
	resizeLearnBanner();
});

resizeLearnBanner();

//Close condition that has to be business learn page
} });