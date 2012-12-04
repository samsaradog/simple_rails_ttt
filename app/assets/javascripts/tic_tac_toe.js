$(document).ready(function() {
	
    $(".remote").bind('ajax:before', function() {
	  $("#spinner").show();
    });
	
	$(".remote").bind('ajax:complete', function(evt, data) {
	  $("#spinner").hide();
	  update_buttons(jQuery.parseJSON(data.responseText).representation);
	  update_notification(jQuery.parseJSON(data.responseText).notification);
	});
	
	function update_buttons(representation) {
		for (i = 0; i < 9; i++) $("#move"+i).text(representation[i])
	};
	
	function update_notification(notification) {
		$("#notification").text(notification)
	};
	
});