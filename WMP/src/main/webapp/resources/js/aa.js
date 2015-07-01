/**
 * 
 */
$(function() {
	$(".chk").bind('click', (function(event) {
		event.stopPropagation();
		var id = $(this).parent().parent().parent().attr('id');
		$(this).parent().next().toggleClass('strike');
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
	var detailI = document.getElementById("detailI");
	$('.todoLi,.todoSLi').not('.chk').bind('click', function(event) {
		event.stopPropagation();
		var no = $(this).attr('id');
		$.ajax({
			url : './detail.html',
			dataType : "html",
			data : "id=" + no,
			async : true,
			success : function(data) {
				// $('#detailI').html(data);
				detailI.innerHTML = data;
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
$(function() {
	$('#year,#month').change(function() {
		var y = document.getElementById("year").value;
		var m = document.getElementById("month").value;
		var url = "calendar.html?y=" + y + "&m=" + m;
		location.href = url;
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
function changeMonth(change) {
	var y = document.getElementById("year").value;
	var m = document.getElementById("month").value;
	var sum = (y * 12) + parseInt(m) + parseInt(change);
	y = Math.floor(sum / 12);
	m = sum % 12;
	var url = "calendar.html?y=" + y + "&m=" + m;
	location.href = url;
}
function modify(id) {
	$.ajax({
		url : './modify.html',
		dataType : "html",
		data : "id=" + id,
		async : true,
		success : function(data) {
			$('#detailI').html(data);
		}
	});
}
function cancelModify(id) {
	$.ajax({
		url : './detail.html',
		dataType : "html",
		data : "id=" + id,
		async : true,
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
		async : true,
		success : function() {
			location.reload();
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

	var container = document.getElementById('map'); // 지도를 담을 영역의 DOM 레퍼런스

	var locX = $("#locX").val();
	var locY = $("#locY").val();
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center : new daum.maps.LatLng(locX, locY), // 지도의 중심좌표
		level : 4
	// 지도의 확대 레벨
	};

	// 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
	var map = new daum.maps.Map(mapContainer, mapOption);

	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new daum.maps.Marker({
		// 지도 중심좌표에 마커를 생성합니다
		position : map.getCenter()
	});
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	map.setZoomable(false);

	function panTo() {
		// 이동할 위도 경도 위치를 생성합니다
		var moveLatLon = new daum.maps.LatLng($("#locX").val(), $("#locY")
				.val());

		// 지도 중심을 부드럽게 이동시킵니다
		// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		map.panTo(moveLatLon);
	}

	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
		var loc = $('#location').val();
		var locArray = loc.split(",");

		//윈도우 창 오픈+타이틀 적용
		var win = window.open("./mapDetail.html?locX=" + locArray[0] + "&locY="
				+ locArray[1], "상세위치(더블클릭하면 닫힙니다)", "width=850, height=700"); // open popup

		setTimeout(function() {
			win.document.title = "상세위치(더블클릭하면 닫힙니다)";
		},500);

		
	});
	daum.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
		panTo();
	});
}

function disablePopup() {
	// disables popup only if it is enabled
	if (popupStatus == 1) {
		$("#backgroundPopup").fadeOut("slow");
		$("#detail").fadeOut("slow");
		popupStatus = 0;
	}
}
