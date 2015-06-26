/**
 * 
 */
$(function() {
	$(".chk").bind('click', (function(event) {
		event.stopPropagation();
		var id = $(this).parent().parent().attr('id');
		$(this).parent().toggleClass('strike');
		$(this).next().toggle(function() {
			$(this).attr('checked', 'checked');
		}, function() {
			$(this).css('display', '');
			$(this).prop('checked', false);
		});
		$.ajax({
			url : './tgl.html',
			dataType : "html",
			data : "id=" + id,
			async : true
		});
	}));
	$('.todoLi,.todoSLi').not('.chk').bind('click', function(event) {
		event.stopPropagation();
		var no = $(this).attr('id');
		$.ajax({
			url : './detail.html',
			dataType : "html",
			data : "id=" + no,
			async : true,
			success : function(data) {
				$('#detailI').html(data);
				setPopupPosition();
				loadPopup();
			}
		});
	});
	$('td,ul').not('.chk,.todoLi,.todoSli,#todoM').bind('click',
			function(event) {
				event.stopPropagation();
				var date = $(this).attr('id');
				$.ajax({
					url : './create.html',
					dataType : "html",
					type : 'get',
					async : true,
					data : "date=" + date,
					success : function(data) {
						$('#detailI').html(data);
						setPopupPosition();
						loadPopup();
					}
				});
			});
	$('#xButton').bind('click', function() {
			disablePopup();
	});
});
$(function() {
	var id = "";
	var date = "";
	$('.todoUl').sortable({
		connectWith : ".todoUl",
		receive : function(ev, ui) {
			var id = ui.item.attr("id");
			var date = $(this).attr("id");
			if (ui.item.hasClass('todoLi')) {
				$.ajax({
					url : './updateEndTime.html',
					dataType : "html",
					async : true,
					data : {
						"id" : id,
						"date" : date
					}
				});
			} else if (ui.item.hasClass('todoSLi')) {
				$.ajax({
					url : './updateDuration.html',
					dataType : "html",
					async : true,
					data : {
						"id" : id,
						"date" : date
					}
				});
			}
		}
	}).disableSelection();
	$('.todoLi,.todoSLi').draggable({
		cursor : "move",
		connectToSortable : ".todoUl",
		containment : 'table',
		revert : "invalid",
		start : function() {
			$(this).css("opacity", "0.3")
		},
		drag : function() {
		},
		stop : function(event, ui) {
			$(this).css("opacity", "1");
		}
	});

});
function cancel() {
	disablePopup();
}
function modify(id) {
	$('#detail').html("");
}
function del(id) {
	if (confirm("삭제하시겠습니까")) {
		location.href = "delete.html?id=" + id;
	}
}
function changeDate() {
	var y = document.getElementById("y").value;
	var m = document.getElementById("m").value;
	var url = "calendar.html?y=" + y + "&m=" + m;
	location.href = url; // url이 가지고 있는 값으로 이동
}
function modify(id) {
	$.ajax({
		url : './modify.html',
		dataType : "html",
		data : "id=" + id,
		async : false,
		success : function(data) {
			$('#detailI').html(data);
		}
	});
}
function tgl(no) {
	$.ajax({
		url : './tgl.html',
		dataType : "html",
		data : "id=" + no,
		async : true
	});
}
/**
 * set popup position
 */
var popupStatus = 0;
var _x = 0;
var _y = 0;
$(function() {
	$(document).mousemove(function(event) {
		_x = event.pageX;
		_y = event.pageY;
	});
});
function setPopupPosition() {
	var windowWidth = document.documentElement.clientWidth; // clientWidth,
															// scrollWidth
	var windowHeight = document.documentElement.clientHeight; // clientHeight,
																// scrollHeight
	var popupHeight = $("#detail").height();
	var popupWidth = $("#detail").width();
	if (popupWidth + _x > windowWidth) {
		_x = _x - popupWidth;
	}
	if (popupHeight + _y > windowHeight) {
		_y = _y - popupHeight;
	}

	// centering
	$("#detail").css({
		"position" : "absolute",
		"hover" : "true",
		"top" : _y,
		"left" : _x
	});
	// only need force for IE6
	$("#backgroundPopup").css({
		"height" : windowHeight
	});

}

function loadPopup() {
	// loads popup only if it is disabled
	if (popupStatus == 0) {
		$("#backgroundPopup").css({
			"opacity" : "1"
		});
		$("#backgroundPopup").fadeIn("slow");
		$("#detail").fadeIn("slow");
		popupStatus = 1;
	}
}
function disablePopup() {
	// disables popup only if it is enabled
	if (popupStatus == 1) {
		$("#backgroundPopup").fadeOut("slow");
		$("#detail").fadeOut("slow");
		popupStatus = 0;
	}
}