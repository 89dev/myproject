package com.myproject.web.board.act;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	private @ResponseBody int boardInsert(MultipartHttpServletRequest multi){
		
		JSONObject insertData = new JSONObject();
		
		// 저장 경로 설정
        String root = multi.getSession().getServletContext().getRealPath("/");
        String path = root+"uploadFiles/";
        
        
        String newFileName = ""; // 업로드 되는 파일명
         
        File dir = new File(path);
        if(!dir.isDirectory()){
            dir.mkdir();
        }
         
        
        Iterator<String> files = multi.getFileNames();
        while(files.hasNext()){
            String uploadFile = files.next();
                         
            MultipartFile mFile = multi.getFile(uploadFile);
            String fileName = mFile.getOriginalFilename();
            
            
            if(!fileName.trim().equals("") && !fileName.trim().isEmpty()){
            	
            	newFileName = System.currentTimeMillis()+"."
                        +fileName.substring(fileName.lastIndexOf(".")+1);
                 
                try {
                    mFile.transferTo(new File(path+newFileName));
                    
                    insertData.put("files_name", newFileName);
                    insertData.put("files_ori_name", fileName);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            
        }
         
        
        insertData.put("category", multi.getParameter("category"));
        insertData.put("subject", multi.getParameter("subject"));
        insertData.put("content", multi.getParameter("content"));
        insertData.put("board_writer", multi.getParameter("board_writer"));
        insertData.put("board_writer_seq", multi.getParameter("board_writer_seq"));

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
	
	@RequestMapping("/fileDown/{files_seq}")
	private void getFile(@PathVariable int files_seq, HttpServletRequest request, HttpServletResponse response){
		
		JSONObject json = mBoardService.fileDetail(files_seq);
		
		//파일 업로드된 경로 
        try{
            String fileUrl = "/Volumes/Seagate0001/Git-Repository/MyProject/MyProject/MyProject/src/main/webapp/uploadFiles";
            fileUrl += "/";
            String savePath = fileUrl;
            String fileName = (String) json.get("files_name");
            
            
            //실제 내보낼 파일명 
            String oriFileName = (String) json.get("files_ori_name");
            InputStream in = null;
            OutputStream os = null;
            File file = null;
            boolean skip = false;
            String client = "";
            
            //파일을 읽어 스트림에 담기  
            try{
                file = new File(savePath, fileName);
                in = new FileInputStream(file);
            } catch (FileNotFoundException fe) {
                skip = true;
            }
            
            client = request.getHeader("User-Agent");
            
            //파일 다운로드 헤더 지정 
            response.reset();
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Description", "JSP Generated Data");
            
            if (!skip) {
                // IE
                if (client.indexOf("MSIE") != -1) {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
                    // IE 11 이상.
                } else if (client.indexOf("Trident") != -1) {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
                } else {
                    // 한글 파일명 처리
                    response.setHeader("Content-Disposition",
                            "attachment; filename=\"" + new String(oriFileName.getBytes("UTF-8"), "ISO8859_1") + "\"");
                    response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
                }
                response.setHeader("Content-Length", "" + file.length());
                os = response.getOutputStream();
                byte b[] = new byte[(int) file.length()];
                int leng = 0;
                while ((leng = in.read(b)) > 0) {
                    os.write(b, 0, leng);
                }
            } else {
                response.setContentType("text/html;charset=UTF-8");
                System.out.println("<script language='javascript'>alert('파일을 찾을 수 없습니다');history.back();</script>");
            }
            in.close();
            os.close();
        } catch (Exception e) {
            System.out.println("ERROR : " + e.getMessage());
        }

	}
}
