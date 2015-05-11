$(document).on("blur", "input[name='user[username]']", function() {
	$.ajax({
		url: "/check-username",
		type: "POST",
		data: {
			username: $(this).val(),
			authenticity_token: $("input[name='authenticity_token']").val()
		},
		success: function(data) {
			if (data.taken === "taken") {
				$("#signup-username-error").slideDown();
			} else {
				$("#signup-username-error").slideUp();
			}
		}
	});
});