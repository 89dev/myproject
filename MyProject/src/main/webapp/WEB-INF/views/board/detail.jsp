<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>

<div class="container">
	
	<div class="row">
		<div class="row" style="border-bottom:2px solid darkgray;">
			<h4>
				<span class="label label-primary" style="border-radius:3px; margin-right:5px;">${detail.BOARD_CATEGORY}</span>
				${detail.BOARD_SUBJECT}
			</h4>
			<span style="float:right;">
				<i class="fa fa-user-circle-o" aria-hidden="true"></i> ${detail.BOARD_WRITER}  
				<i class="fa fa-clock-o" aria-hidden="true"></i> ${detail.BOARD_INSERT_DATE}  
				<b>${detail.BOARD_HIT}</b>
			</span>
		</div>
		
		<div class="row" style="padding:25px; border-bottom:2px solid darkgray;">
			<a href="/board/fileDown/${detail.FILES_SEQ}" style="margin-bottom : 5px;">${detail.FILES_ORI_NAME}</a>
			<p>${detail.BOARD_CONTENT}</p>
			
			<div class="row" style="margin-top : 20px;">
				<center>
				<button type="button" class="btn btn-default">
					<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
				</button>
				<button type="button" class="btn btn-default">
					<i class="fa fa-taxi" aria-hidden="true"></i>
				</button>
				</center>
			</div>
		</div>
		
		<div class="row" style="float:right; margin-top : 10px;">
			<button type="button" class="btn btn-default btn-sm" name="deleteBtn">삭제</button>
			<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#updateModal">수정</button>
		</div>
	</div>
	
	<div class="row" style="margin-top:20px;">
		<div class="row">
			<label>코멘트 (${detail.COMM_COUNT})</label>
			
			<table class="table table-hover">
				<tbody class="commArea"></tbody>
			</table>
		</div>
		
		<div class="row" >
			<form name="commForm">
			  	<div class="form-group" style="margin-bottom:5px;">
			   		<textarea class="form-control" name="comm_content" placeholder="comment" rows="3"></textarea>
			  	</div>
			  	<!-- 임시 -->
			  	<input type="hidden" name="comm_writer" value="testwirter"/>
			  	<input type="hidden" name="comm_writer_seq" value="1"/>
			  	<input type="hidden" name="board_seq" value="${detail.BOARD_SEQ}"/>
			  	
			  	<button type="button" class="btn btn-default btn-sm" style="float:right;" onclick="commInsert();">등록</button>
			</form>
		</div>
	</div>
	
	<div class="row" style="margin-top:50px;">
		<table class="table table-hover">
			<thead>
				<tr>
					<th width="10%;">No</th>
					<th>Subject</th>
					<th width="12%;">Writer</th>
					<th width="15%;">Date</th>
					<th width="10%;">Hit</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="b" items="${list}">
				<tr>
					<td>${b.BOARD_SEQ}</td>
					<td onclick="location.href='/board/${b.BOARD_SEQ}'" style="cursor:pointer;">${b.BOARD_SUBJECT}</td>
					<td>${b.BOARD_WRITER}</td>
					<td>${b.BOARD_INSERT_DATE}</td>
					<td>${b.BOARD_HIT}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="updateModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        
        <form name="updateForm">
       		<div class="form-group">
		    	<select class="form-control form-group-sm" name="category" id="category">
		    		<option value="1">cate1</option>
		    		<option value="2">cate2</option>
		    		<option value="3">cate3</option>
		    	</select>
		  	</div>
		  	<div class="form-group">
		    	<input type="text" class="form-control" name="subject" placeholder="Subject" value="${detail.BOARD_SUBJECT}">
		  	</div>
		  	<div class="form-group">
		   		<textarea class="form-control" name="content" rows="10">${detail.BOARD_CONTENT}</textarea>
		  	</div>
		  	
		  	<!-- 임시 -->
		  	<input type="hidden" name="board_writer" value="testwirter"/>
		  	<input type="hidden" name="board_writer_seq" value="1"/>
		  	<input type="hidden" name="board_seq" value="${detail.BOARD_SEQ}"/>
		</form>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="updateBoard();">Save changes</button>
      </div>
    </div>
  </div>
</div>

<%@ include file="detailS.jsp" %>
</layoutTag:layout>