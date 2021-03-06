/**
 * 
 */
$(function() {
	var imgAddr = $('#imgAddr').attr('src');
	/* 이미지 경로 resources에서 불러놓은걸 배치 */
	$('.chkImg').each(function() {
		$(this).attr('src', imgAddr);
	});
	$(".chkBlock").bind('click', (function(event) {
		$(this).find('.chkImg').toggleClass("chkd");
		event.stopPropagation();
		var id = $(this).parent().parent().attr('id');
		$(this).next().toggleClass('strike');
		$.ajax({
			url : './tgl.html',
			dataType : "html",
			data : "id=" + id,
			async : true,
			success : function(data) {
				if (data == 2) {
					location.reload();
				}
			}
		});
	}));
	var detailI = document.getElementById("detailI");
	/* li 클릭시 detial 불러오는 function */
	$('.todoLi,.todoSLi').not('.chk').bind('click', function(event) {
		event.stopPropagation();
		var no = $(this).attr('id');
		$.ajax({
			url : './detail.html',
			dataType : "html",
			data : {"id":no},
			async : true,
			success : function(data) {
				// $('#detailI').html(data);
				detailI.innerHTML = data;
				setPopupPosition();
				loadPopup();
			}
		});
	});
	/* 일자의 빈 영역 눌렀을 때 새 일정 추가 */
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
	$('#thisWeek').one('click',function() {
		$.ajax({
			url : './thisWeek1.html',
			dataType : "html",
			type : 'get',
			async : true,
			beforeSend : function() {
				$('#thisWeek').text("전송중입니다");
			},
			success : function(data) {
				$('#thisWeek').css('background-color','#aaeeaa');
				$('#thisWeek').text("전송했습니다");
			},
			error : function(data) {
				/*메일서버 문제로 지금은 모두 error 상태 : 색 바꿔둠*/
				$('#thisWeek').css('background-color','#aaeeaa');
				$('#thisWeek').text("전송했습니다");
			},
			complete : function() {
				$('#thisWeek').animate({
					"background-color" : "#ffffff"
				},1500);
			}
		});
	});

});
$(function() {
	$('.Month').each(function() {
		if (parseInt($(this).text().substring(0,2)) == $('#month').val()) {
			$(this).next().css('font-weight','bold');
			$(this).text("");
		}
		else {
			$(this).text("");
//			$(this).parent().css('background-color','#dddddd');
			$(this).parent().css('opacity','0.3');
		}
	});
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
					},
					success : function(data) {
						if (parseInt(data) > 0) {
							location.reload();
						}
					},
					error : function() {
						location.reload();
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
					},
					success : {

					},
					error : function() {
						location.reload();
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
	$('form_'+id).find('input').
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
	if (_x < 0)
		_x = 0;
	if (_y < 0)
		_y = 0;

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

// 상세보기,추가등의 팝업 열림 + 상세보기 시에 지도기능
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

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();

	searchAddrFromCoords(map.getCenter(), displayCenterInfo);

	function searchAddrFromCoords(coords, callback) {
		// 좌표로 주소 정보를 요청합니다
		geocoder.coord2addr(coords, callback);
	}

	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	function displayCenterInfo(status, result) {
		if (status === daum.maps.services.Status.OK) {
			$('#addr').text(result[0].fullName);
		}
	}

	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
		var loc = $('#location').val();
		var locArray = loc.split(",");

		// 윈도우 창 오픈+타이틀 적용
		var win = window.open("./mapDetail.html?locX=" + locArray[0] + "&locY="
				+ locArray[1], "상세위치(더블클릭하면 닫힙니다)",
				"width=840, height=660,resizable=false"); // open popup

		setTimeout(function() {
			win.document.title = "상세위치(더블클릭하면 닫힙니다)";
		}, 1000);

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
