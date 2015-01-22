//Execute only when forgot password page is shown
$(document).ready(function() {
if ($("#page_id").length && $("#page_id").val() === "forgot_password") {

$(document).on("click", "#step1-button", function(event) {
	event.preventDefault();

	$(this).attr("disabled", "disabled").html("Loading...");

	$.ajax({
		url: "/forgot-password/1",
		type: "POST",
		data: {
			authenticity_token: $("input[name=authenticity_token]").val(),
			email_address: $("#reset-email").val()
		},
		success: function(data) {
			if (data.result === "ok") {
				$("#error-container").hide();
				$("#step1").slideUp();
				$("#step2").removeClass("hide");
			} else {
				$("#error-container").slideDown();
				$("#reset-error-text").html(data.error);
				$("#step1-button").removeAttr("disabled").html("Reset Your Password");
			}
		},
		error: function() {
			alert("There was an error processing your request.");
		}
	});
});

$(document).on("click", "#step2-button", function(event) {
	event.preventDefault();

	$.ajax({
		url: "/forgot-password/2",
		type: "POST",
		data: {
			authenticity_token: $("input[name=authenticity_token]").val(),
			email_address: $("#reset-email").val(),
			reset_token: $("#reset-token").val()
		},
		success: function(data) {
			if (data.result === "ok") {
				$("#error-container").hide();
				$("#step2").slideUp();
				$("#step3").removeClass("hide");
			} else {
				$("#error-container").slideDown();
				$("#reset-error-text").html(data.error);
			}
		},
		error: function() {
			alert("There was an error processing your request.");
		}
	});
});

$(document).on("click", "#step3-button", function(event) {
	event.preventDefault();

	if ($("#new-password-1").val() !== $("#new-password-2").val()) {
		$("#error-container").slideDown();
		$("#reset-error-text").html("Your passwords don't match");
		return false;
	}

	$.ajax({
		url: "/forgot-password/3",
		type: "POST",
		data: {
			authenticity_token: $("input[name=authenticity_token]").val(),
			email_address: $("#reset-email").val(),
			reset_token: $("#reset-token").val(),
			new_password: $("#new-password-1").val()
		},
		success: function(data) {
			if (data.result === "ok") {
				$("#error-container").hide();
				$("#step3").slideUp();
				$("#reset-confirmation").removeClass("hide");
			} else {
				$("#error-container").slideDown();
				$("#reset-error-text").html(data.error);
			}
		},
		error: function() {
			alert("There was an error processing your request.");
		}
	});
});

$(document).on("focus", "#reset-email", function() {
	$("#error-container").slideUp();
});

//Close condition that forgot password page
} });