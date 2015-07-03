/**
 * 
 */

$(function() {
	$('.header').bind('click', function() {
		$(this).next().toggle(500);
	});
	$('#expandText').bind('click', function() {
		$('.main').each(function() {
			$(this).toggle(500);
		});
/*		$('#expandText').toggle(function() {
			text('닫기');
		},function() {
			text('펼치기');
		});*/
	});
});