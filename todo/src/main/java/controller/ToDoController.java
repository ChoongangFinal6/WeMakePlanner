package controller;

import model.ToDo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ToDoController {
	@Autowired
	private ToDo todo;
	
	@RequestMapping(value="calendar")
	public String calendar() {
		return "todo/calendar";
	}


}
 