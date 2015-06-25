/**
 * 
 */
$(function() {
	$(".chk").bind('click', (function() {
		var id = $(this).parent().attr('id');
		$.ajax({
			url : './tgl.html',
			dataType : "html",
			data : "id=" + id,
			async : true
		});
		/* $(this).toggle(this.checked); */
		/* $(this).prop("checked",!$(this).prop("checked")); */
		$(this).parent().toggleClass('strike');
		$(this).toggle(function() {
			$(this).attr('checked', 'checked');
		}, function() {
			$(this).css('display', '');
			$(this).prop('checked', false);
		});
	}));
});
$(function() {
	var id = "";
	var date = "";
	$('.dayUl').sortable({
		connectWith : ".dayUl",
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
		connectToSortable : ".dayUl",
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

	$('td').bind('click', function() {
		var date = $(this).attr('id');
		$.ajax({
			url : './create.html',
			dataType : "html",
			type : 'get',
			async : true,
			data : "date=" + date,
			success : function(data) {
				$('#detail').html(data);
				setPopupPosition();
				loadPopup();
			}
		});
	});
	$('.todoLi,.todoSLi').not('.chk').bind('click', function() {
		var no = $(this).attr('id');
		$.ajax({
			url : './detail.html',
			dataType : "html",
			data : "id=" + no,
			async : true,
			success : function(data) {
				$('#detail').html(data);
				setPopupPosition();
				loadPopup();
			}
		});
	});
	$.not('table').bind('click', function() {
		cancel();
		return false;
	});
});
function cancel() {
	alert("cancel");
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
			$('#detail').html(data);
		}
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
		alert(event.pageX);
		_x = event.pageX;
		_y = event.pageY;
	});
});
function setPopupPosition() {
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.scrollHeight; // clientHeight;
	var popupHeight = $("#detail").height();
	var popupWidth = $("#detail").width();
	alert(_x);

	// centering
	$("#detail").css({
		"position" : "absolute",
		"hover" : "true",
		"top" : _y, // windowHeight/2-popupHeight/2,
		"left" : _x
	// windowWidth/2-popupWidth/2
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
			"opacity" : "0.9"
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