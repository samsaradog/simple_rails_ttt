$(document).ready(function() {
	
	$(".update").bind('ajax:complete', function(evt, data) {
	  update_player_buttons(jQuery.parseJSON(data.responseText).representation);
	  update_player_notification(jQuery.parseJSON(data.responseText).notification);
	});
	
	function update_player_buttons(representation) {
		for (i = 0; i < 9; i++) $("#player_move"+i).text(representation[i])
	};
	
	function update_player_notification(notification) {
		$("#player_notification").text(notification)
	};

	function get_update() {
		$.get('/get_update', function(data) {
		  update_player_buttons(data.representation);
		  update_player_notification(data.notification);
		})
	}

	setInterval(get_update, 1000);

});