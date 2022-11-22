package com.kh.forworks.off.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.forworks.DateFunction;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.off.service.OffService;
import com.kh.forworks.off.vo.OffCntVo;
import com.kh.forworks.off.vo.OffTypeVo;
import com.kh.forworks.off.vo.OffVo;


@Controller
@RequestMapping("off")
public class OffController {

	private final OffService service;
	private final int offConfirmPos = 3;
	
	@Autowired
	public OffController(OffService service) {
		this.service = service;
	}
	
	@GetMapping("manage")
	public String offManage(Model model, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		
		OffCntVo offCnt = service.getOffCnt(empNo);
		List<OffTypeVo> offTypeList = service.getOffTypeList();
		
		model.addAttribute("offCnt", offCnt);
		model.addAttribute("offTypeList", offTypeList);
		model.addAttribute("joinDay", loginMember.getEmpJdate().substring(0,4));
		
		return "off/offManagement";
	}
	
	@GetMapping("confirm")
	public String offConfirm(Model model, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String month = DateFunction.getThisMonth();
		//권한 있는지 없는지 확인
		String posNo = loginMember.getPosNo();
		if(Integer.parseInt(posNo) <= offConfirmPos) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("deptNo", loginMember.getDeptNo());
			map.put("month", month);
			
			List<OffVo> OffList = service.getDeptOffList(map);
			model.addAttribute("OffList", OffList);
			
		} else {
			session.setAttribute("toastMsg", "열람 권한이 없습니다.");
		}
		
		model.addAttribute("month", month);
		
		return "off/offConfirm";
	}

	@PostMapping("offInfo")
	@ResponseBody
	public List<OffVo> getOffInfo(String year, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("year", year);
		
		List<OffVo> offList = service.getOffList(map);
		
		return offList;
	}
	
	@PostMapping("submitOff")
	@ResponseBody
	public String submitOffForm(String start, String end ,int type, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("start", start);
		map.put("end", end);
		map.put("type", type);
		
		int result = service.submitOff(map);
		
		if(result == 1) {
			return "success";			
		} else {
			return "fail";
		}
	}
	
	@PostMapping("deptOffList")
	@ResponseBody
	public List<OffVo> getDeptOffList(String month, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		//권한 있는지 없는지 확인
		String posNo = loginMember.getPosNo();
		if(Integer.parseInt(posNo) <= offConfirmPos) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("deptNo", loginMember.getDeptNo());
			map.put("month", month);
			
			List<OffVo> OffList = service.getDeptOffList(map);
			return OffList;
		} else {
			return null;
		}
	}
	
	@GetMapping("accept")
	public String offAccept(@RequestParam String no[], HttpSession session) {	
		int result = service.setOffAccept(no);
		
		if(result == 1) {			
			return "redirect:/off/confirm";
		} else {
			session.setAttribute("toastMsg", "에러가 발생했습니다. 나중에 다시 시도해주세요.");
			return "redirect:/off/confirm";
		}
		
	}
	
	@GetMapping("reject")
	public String offReject(@RequestParam String no[], HttpSession session) {	
		int result = service.setOffReject(no);
		
		if(result == 1) {			
			return "redirect:/off/confirm";
		} else {
			session.setAttribute("toastMsg", "에러가 발생했습니다. 나중에 다시 시도해주세요.");
			return "redirect:/off/confirm";
		}
		
	}
	
}
