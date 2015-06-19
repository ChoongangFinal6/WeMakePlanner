package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ToDoController {
	@RequestMapping(value="calendar")
	public String calendar() {
		return "todo/calendar";
	}


}
 