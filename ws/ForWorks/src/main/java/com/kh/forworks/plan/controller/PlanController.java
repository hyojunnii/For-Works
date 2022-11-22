package com.kh.forworks.plan.controller;
import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.kh.forworks.plan.dto.PlanDto;
import com.kh.forworks.plan.service.PlanService;
import com.kh.forworks.plan.vo.PlanVo;

@Controller
public class PlanController {
	
	@Inject
	private PlanService service;
	
	//일정 캘린더 화면 보여주기
	@GetMapping("plan/calendar")
	public String calendar(Model model) throws Exception  {
		//voList = service.selectist();
		//model.addAttribute("showSchedule", voList);
		
		List<PlanDto> list = service.showSchedule();
		model.addAttribute("showSchedule" , list);
		
		return "plan/calendar";
	}
	
	


	//일정 추가 버튼 클릭 Ajax		
	@ResponseBody
	@PostMapping("plan/addSchedule")
	public String addSchedule(PlanDto dto) throws Exception{
		
		System.out.println("화면에서 보낸 데이터 :::" + dto);

		int result = service.addSchedule(dto);

		return result + "";
	}

	//팝업창에서 일정 등록되면, 캘린더에 일정이 추가된 모습 보여주기
	@RequestMapping(value = "/plan")
	public String schedule(Model model)throws Exception {

		model.addAttribute("showSchedule" , service.showSchedule());
	    
		return "plan/calendar"; 
	}
	
	
	  /**
     * 이벤트 일정 삭제
     */
    @RequestMapping(value = "/delete")
    public String postdelete(Model model)throws Exception {
    		model.addAttribute("showSchedule", service.showSchedule());
        return "plan/calendar";
    }
	
}//class
		
		
	







	
	
	
	
	

	