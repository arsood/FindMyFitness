$(document).on("blur", "input[name='user[email_address]'], input[name='new_email']", function() {
	$.ajax({
		url: "/check-email",
		type: "POST",
		data: {
			email_address: $(this).val(),
			authenticity_token: $("input[name='authenticity_token']").val()
		},
		success: function(data) {
			if (data.taken === "taken") {
				$("#signup-email-error").slideDown();
			} else {
				$("#signup-email-error").slideUp();
			}
		}
	});
});