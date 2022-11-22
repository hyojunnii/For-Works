package com.kh.forworks.todo.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller

public class ToDoController {
	
	
	//투두리스트 보여주기
	@RequestMapping("todo/newTodo")
	public String newTodo() {
		System.out.println("asd");
			return "todo/newTodo";
		}

}		

