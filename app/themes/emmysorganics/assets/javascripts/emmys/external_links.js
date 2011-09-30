$(function() {
	$('a:not([href=""])').each(function() {
		if (this.hostname !== location.hostname) {
			$(this).addClass('externalLink').attr('target', "_blank");
		}
	});
});