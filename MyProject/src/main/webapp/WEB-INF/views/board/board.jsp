<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>

<div class="container">
	<div class="row">
		<form name="searchForm">
			<div class="form-group form-group-sm col-xs-1" style="padding-left:0px;">
		    	<select class="form-control" name="category">
		    		<option value="">CATE</option>
		    		<option value="1">cate1</option>
		    		<option value="2">cate2</option>
		    		<option value="3">cate3</option>
		    	</select>
			</div>
			
			<div class="form-group form-group-sm" data-toggle="modal" data-target="#insertModal" style="padding-right:0px;float:right;">
				<button class="btn btn-default btn-sm" type="button">
					<i class="fa fa-pencil" aria-hidden="true"></i>
				</button>
			</div>
			
			<div class="form-group form-group-sm col-xs-2" style="padding-right:5px;float:right;">
			    <div class="input-group">
			      <input type="text" class="form-control" placeholder="Search for...">
			      <span class="input-group-btn">
			        <button class="btn btn-default btn-sm" type="button">Go!</button>
			      </span>
			    </div><!-- /input-group -->
			</div>
		</form>
	</div>
	
	<div class="row">
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
			<tbody class="listArea"></tbody>
		</table>
	</div>
</div>

<!-- Insert Modal -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="insertModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="insertModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        
        <form name="insertForm">
       		<div class="form-group">
		    	<select class="form-control form-group-sm" name="category" id="category">
		    		<option value="1">cate1</option>
		    		<option value="2">cate2</option>
		    		<option value="3">cate3</option>
		    	</select>
		  	</div>
		  	<div class="form-group">
		    	<input type="text" class="form-control" name="subject" placeholder="Subject">
		  	</div>
		  	<div class="form-group">
		   		<textarea class="form-control" name="content" placeholder="Content" rows="10"></textarea>
		  	</div>
		  	<div class="form-group">
		    	<label for="exampleInputFile">파일 업로드</label>
		    	<input type="file" id="exampleInputFile" name="files">
		    	<p class="help-block">파일 크기 어쩌구 저쩌구</p>
		  	</div>
		  	
		  	<!-- 임시 -->
		  	<input type="hidden" name="board_writer" value="testwirter"/>
		  	<input type="hidden" name="board_writer_seq" value="1"/>
		</form>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="insertBoard();">Save changes</button>
      </div>
    </div>
  </div>
</div>

<%@ include file="boardS.jsp" %>
</layoutTag:layout>