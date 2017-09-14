package com.myproject.web.index.act;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class IndexAct {

	@RequestMapping({"","/"})
	private String index(){
		return "index";
	}
}
