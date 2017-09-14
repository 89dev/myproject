package com.myproject.web.board.act;

import java.util.List;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myproject.config.interceptor.URLConstant;
import com.myproject.web.board.service.BoardService;


@Controller
@RequestMapping(URLConstant.URL_BOARD)
public class BoardController {

	@Resource(name="com.myproject.web.board.service.BoardService")
	BoardService mBoardService;
	
	@RequestMapping(value={"/",""}, method=RequestMethod.GET)
	private String boardIndex(){
		return URLConstant.URL_BOARD+"/board";
	}
	
	@RequestMapping("/getBoardList")
	private @ResponseBody List<JSONObject> getBoardList(){
		return mBoardService.boardListService();
	}
	
	@RequestMapping(value={"/",""}, method=RequestMethod.POST)
	private @ResponseBody int boardInsert(@RequestBody JSONObject insertData){
		return mBoardService.boardInsertService(insertData);
	}
	
	@RequestMapping(value="/{board_seq}", method=RequestMethod.GET)
	private String boardDetail(@PathVariable int board_seq, Model model){
		
		model.addAttribute("detail", mBoardService.boardDetailService(board_seq));
		model.addAttribute("list", 	 mBoardService.boardListService());
		
		return URLConstant.URL_BOARD+"/detail";
	}
	
	@RequestMapping(value="/{board_seq}", method=RequestMethod.PATCH)
	private @ResponseBody int boardUpdate(@RequestBody JSONObject insertData){
		return mBoardService.boardUpdateService(insertData);
	}
	
	@RequestMapping(value="/{board_seq}", method=RequestMethod.DELETE)
	private @ResponseBody int boardDelete(@PathVariable int board_seq){
		return mBoardService.boardDeleteService(board_seq);
	}
}
