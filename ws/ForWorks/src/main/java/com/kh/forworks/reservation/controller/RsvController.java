package com.kh.forworks.reservation.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("rsv")
public class RsvController {
		
 
	//예약리스트 
	@GetMapping("list")
	public String list() {
		return "reservation/list";
	}
	
	//예약등록
	@GetMapping("create")
	public String create() {
		
		return "reservation/create";
	}
	
	//예약정보 확인
	@GetMapping("detail")
	public String detail() {
		
		return "reservation/detail";
	}
	
	//예약수정
	@GetMapping("update")
	public String update() {
		
		return "reservation/update";
	}
}
