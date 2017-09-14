package com.myproject.mapper;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

@Repository("com.myproject.mapper.BoardMapper")
public interface BoardMapper {

	public List<JSONObject> board_list();
	
	public int board_insert(JSONObject insertData);
	
	public JSONObject board_detail(int board_seq);
	
	public int board_update(JSONObject updateData);
	
	public int board_delete(int board_seq);
}
