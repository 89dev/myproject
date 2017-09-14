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
		return mBoardMapper.board_insert(insertData);
	}
	
	public JSONObject boardDetailService(int board_seq){
		return mBoardMapper.board_detail(board_seq);
	}
	
	public int boardUpdateService(JSONObject updateData){
		return mBoardMapper.board_update(updateData);
	}
	
	public int boardDeleteService(int board_seq){
		return mBoardMapper.board_delete(board_seq);
	}
}
