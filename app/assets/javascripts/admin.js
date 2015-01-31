//Remove an event

function deleteItem(scope, confirmDelete, type) {
	if (confirmDelete) {
		$.ajax({
			url: "/admin/delete",
			type: "POST",
			data: {
				type: type,
				id: $(scope).attr("data-id"),
				authenticity_token: $("input[name=authenticity_token]").val()
			},
			success: function(data) {
				if (data.result === "ok") {
					window.location.href="/admin";
				} else {
					alert(data.error);
				}
			},
			error: function() {
				alert("There was an error processing the delete.");
			}
		});
	} else {
		return false;
	}
}

$(document).on("click", "#super-user-delete-event", function(event) {
	event.preventDefault();

	var confirmDelete = confirm("Are you sure you want to delete this event? This cannot be undone.");

	deleteItem(this, confirmDelete, "event");
});

$(document).on("click", "#super-user-delete-post", function(event) {
	event.preventDefault();

	var confirmDelete = confirm("Are you sure you want to delete this post? This cannot be undone.");

	deleteItem(this, confirmDelete, "post");
});

$(document).on("click", "#super-user-delete-business", function(event) {
	event.preventDefault();

	var confirmDelete = confirm("Are you sure you want to delete this business? This cannot be undone.");

	deleteItem(this, confirmDelete, "business");
});
