/**
 * 
 */
	$(function() {
		var id = "";
		var date = "";
		$('#draggable').draggable();
		$('.todo,.todoS').draggable({
			cursor : "move",
			start : function() {
				$(this).css("opacity", "0.3")
			},
			drag : function() {
			},
			stop : function(event, ui) {
				$(this).css("opacity", "1");
			}
		});
		$(".day").droppable({
			accept : '#draggable,.todo,.todoS',
			drop : function(ev, ui) {
				//to get the id
				//ui.draggable.attr('id') or ui.draggable.get(0).id or ui.draggable[0].id
				var id = ui.draggable.attr("id");
				var date = $(this).attr("id");
				// Alert draggable elment id and dropable element Id
				//alert("draggable Element Id" + draggableId + " dropableId  " + droppableId);
				$.post({
					url : './update.jsp',
					dataType : "html",
					data : {
						"id" : id,
						"date" : date
					},
					success : function(data) {
						$('#detail').html(data);
					}
				});
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
				}
			});
		});
		$('.todo,.todoS').bind('click', function() {
			var no = $(this).attr('id');
			$.ajax({
				url : './detail.html',
				dataType : "html",
				data : "id=" + no,
				async : true,
				success : function(data) {
					$('#detail').html(data);
				}
			});
		});
	});
	function cancel() {
		$('#detail').html("");
	}
	function modify(id) {
		$('#detail').html("");
	}
	$(function() {
		$(".chk").bind('click',(function() {
			var id = $(this).parent().attr('id');
			$.ajax({
				url : './tgl.html',
				dataType : "html",
				data : "id=" + id,
				async : true
			});
			/*$(this).toggle(this.checked);*/ 
			/*$(this).prop("checked",!$(this).prop("checked"));*/
			$(this).parent().toggleClass('strike');
		    $(this).toggle(
		            function () { 
		                $(this).attr('checked','checked');
		            },
		            function () { 
		            	$(this).css('display', '');
		                $(this).prop('checked', false);
		            }
		        );
		}));
	});
	
	function del(id) {
		if (confirm("삭제하시겠습니까")) {
			location.href = "delete.html?id=" + id;
		}
	}
	function changeDate() {
		var y = document.getElementById("y").value;
		var m = document.getElementById("m").value;
		var url = "calendar.html?y=" + y + "&m=" + m;
		location.href = url; //url이 가지고 있는 값으로 이동
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
	function setPopupPosition(){
	    var windowWidth = document.documentElement.clientWidth;
	    var windowHeight = document.documentElement.scrollHeight; //clientHeight;
	    var popupHeight = $("#detail").height();
	    var popupWidth = $("#detail").width();
	    
	    //centering
	    $("#detail").css({
	        "position": "absolute",
	        "top": 0, //windowHeight/2-popupHeight/2,
	        "left": windowWidth/2-popupWidth/2
	    });
	    //only need force for IE6
	    $("#backgroundPopup").css({
	        "height": windowHeight
	    });
	    
	}
	function loadPopup(){
	    //loads popup only if it is disabled
	    if(popupStatus==0){
	        $("#backgroundPopup").css({
	            "opacity": "0.7"
	        });
	        $("#backgroundPopup").fadeIn("slow");
	        $("#detail").fadeIn("slow");
	        popupStatus = 1;
	    }
	}
	function disablePopup(){
	    //disables popup only if it is enabled
	    if(popupStatus==1){
	        $("#backgroundPopup").fadeOut("slow");
	        $("#detail").fadeOut("slow");
	        
	        popupStatus = 0;
	    }
	}