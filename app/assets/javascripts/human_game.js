$(document).ready(function() {
	
	$(".update").bind('ajax:complete', function(evt, data) {
	  update_human_buttons(jQuery.parseJSON(data.responseText).representation);
	  update_human_notification(jQuery.parseJSON(data.responseText).notification);
	});
	
	function update_human_buttons(representation) {
		for (i = 0; i < 9; i++) $("#human_move"+i).text(representation[i])
	};
	
	function update_human_notification(notification) {
		$("#human_notification").text(notification)
	};

	function get_update() {
		$.get('/get_update', function(data) {
		  update_human_buttons(data.representation);
		  update_human_notification(data.notification);
		})
	}

	setInterval(get_update, 1000);

});