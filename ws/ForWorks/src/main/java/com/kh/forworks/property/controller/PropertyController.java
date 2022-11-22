package com.kh.forworks.property.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("property")
public class PropertyController {
	
		
		// 자산 리스트
		@GetMapping("list")
		public String vote() {
			
			return "property/list";
		}
		
		//자산 생성
		@GetMapping("create")
		public String create() {
			return "property/create";
		}
		
		//자산 상세보기(생성자)
		@GetMapping("detail")
		public String deatil() {
			return "property/detail";
		}
		
		//자산 정보수정
		@GetMapping("detailCreator")
		public String update() {
			return "property/update";
		}
		


	
}
