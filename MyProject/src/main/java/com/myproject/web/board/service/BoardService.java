package com.myproject.web.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.myproject.mapper.BoardMapper;

@Service("com.myproject.web.board.service.BoardService")
public class BoardService {

	@Resource(name="com.myproject.mapper.BoardMapper")
	BoardMapper mBoardMapper;
	
	public List<JSONObject> boardListService(){
		return mBoardMapper.board_list();
	}
	
	public int boardInsertService(JSONObject insertData){
		
		int result = 0;
		
		
		if(insertData.containsKey("files_name") && insertData.containsKey("files_ori_name")){
			result = mBoardMapper.board_insert(insertData);
			insertData.put("board_seq", insertData.get("idx"));
			mBoardMapper.file_insert(insertData);
			
		}else{
			result = mBoardMapper.board_insert(insertData);
		}
		
		return result;
	}
	
	public JSONObject boardDetailService(int board_seq){
		
		JSONObject updateData = new JSONObject();
		updateData.put("board_seq", board_seq);
		updateData.put("board_hit", "hit");
		
		mBoardMapper.board_update(updateData);
		
		return mBoardMapper.board_detail(board_seq);
	}
	
	public int boardUpdateService(JSONObject updateData){
		return mBoardMapper.board_update(updateData);
	}
	
	public int boardDeleteService(int board_seq){
		return mBoardMapper.board_delete(board_seq);
	}
	
	
	
	
	
	//file
	public JSONObject fileDetail(int files_seq){
		return mBoardMapper.file_detail(files_seq);
	}
	
}
