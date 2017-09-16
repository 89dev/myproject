<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>

jQuery.fn.serializeObject = function() {
    var obj = null;
    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                jQuery.each(arr, function() {
                    obj[this.name] = this.value;
                });
            }//if ( arr ) {
        }
    } catch (e) {
        alert(e.message);
    } finally {
    }
 
    return obj;
};



/* function insertBoard(){
	var formData = $('[name=insertForm]').serializeObject();
	console.log(formData);
	
	$.ajax({
		url : "/board/",
		type : "post",
		dataType : "json",
		contentType: "application/json",
		data : JSON.stringify(formData),
		success : function(data){
			if(data == 1){
				location.replace('/board');
			}
		}
	});
} */


function insertBoard(){
	var formData = new FormData($('[name=insertForm]')[0]);
	$.ajax({
		type:'post',
		url:'/board/',
		data: formData,
		processData: false,
		contentType: false,
		success: function(data){
			if(data == 1){
				location.replace('/board');
			}
		}
	});
}

function getList(){
	$.ajax({
		url : '/board/getBoardList',
		type : 'get',
		success : function(data){
			
			var a =''; 
			$.each(data, function(key, value){ 
				a += '<tr>';
				a += '<td>'+value.BOARD_SEQ+'</td>';
				a += '<td onclick="location.href=\'/board/'+value.BOARD_SEQ+'\'"; style="cursor:pointer;">'+value.BOARD_SUBJECT+'</td>';
				a += '<td>'+value.BOARD_WRITER+'</td>';
				a += '<td>'+value.BOARD_INSERT_DATE+'</td>';
				a += '<td>'+value.BOARD_HIT+'</td>';
				a += '</tr>';
			});
			
			$(".listArea").html(a);
		}
	});
}

$(document).ready(function(){
	getList();
});
</script>