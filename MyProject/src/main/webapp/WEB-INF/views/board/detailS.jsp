<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>

var board_seq = '${detail.BOARD_SEQ}';

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



function updateBoard(){
	var formData = $('[name=updateForm]').serializeObject();
	console.log(formData);
	
	$.ajax({
		url : "/board/"+board_seq,
		type : "PATCH",
		dataType : "json",
		contentType: "application/json",
		data : JSON.stringify(formData),
		success : function(data){
			if(data == 1){
				alert('수정되었습니다.');
				location.reload();
			}
		}
	});
}




function deleteBoard(){
	$.ajax({
		url : "/board/"+board_seq,
		type : "DELETE",
		success : function(data){
			if(data == 1){
				alert('삭제되었습니다.');
				location.href='/board';
			}
		}
	});
}


function commList(){
	$.ajax({
		url : "/comm/"+board_seq,
		type : "get",
		success : function(data){
			
			var a =''; 
			$.each(data, function(key, value){ 
				a += '<tr>';
				a += '<td>'+value.COMMENT_CONTENT+'</td>';
				a += '<td width="10%">'+value.COMMENT_WRITER+'</td>';
				a += '<td width="20%">'+value.COMMENT_INSERT_DATE+'</td>';
				a += '</tr>';
			});
			
			$(".commArea").html(a);
		}
	});
}


function commInsert(){
	var formData = $('[name=commForm]').serializeObject();
	
	$.ajax({
		url : "/comm/"+board_seq,
		type : "post",
		dataType : "json",
		contentType: "application/json",
		data : JSON.stringify(formData),
		success : function(data){
			commList();
			$('[name=comm_content]').val('');
		}
	});
}


$(document).ready(function(){
	
	commList();
	
	$('[name=deleteBtn]').click(function(){
		var result = confirm('삭제하시겠습까?'); 
		
		if(result) deleteBoard();
		else return false;
	});
	
});
</script>