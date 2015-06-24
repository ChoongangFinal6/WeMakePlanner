package controller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import service.ToDoService;

@Controller
public class ToDoController {
	@Autowired
	ToDoService ts;

	@RequestMapping(value = "calendar")
	public String calendar(String y, String m, Model model) {
		Calendar cal = Calendar.getInstance(); // 현재 시스템이 가지고 있는 날짜 데이터 가지고 오기
		if (y != null && y != "null" && !y.equals("")) {
			System.out.println(y);
			cal.set(Calendar.YEAR, Integer.parseInt(y));
		}
		if (m != null && m != "null" && !m.equals("")) {
			cal.set(Calendar.MONTH, Integer.parseInt(m) - 1);
		}
		cal.set(Calendar.DATE, 1);
		HashMap<Integer, List<ToDo>> todo = ts.endTotal(cal);
		HashMap<Integer, List<ToDo>> todoS = ts.startTotal(cal);
		model.addAttribute("cal", cal);
		model.addAttribute("todoS", todoS);
		model.addAttribute("todo", todo);
		model.addAttribute("y", cal.get(Calendar.YEAR));
		model.addAttribute("m", cal.get(Calendar.MONTH));
		model.addAttribute("w", cal.get(Calendar.DAY_OF_WEEK));
		return "todo/calendar";
	}
	
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(@ModelAttribute("todo") ToDo todo, BindingResult result, String date, Model model) {
		Date dt = new Date();
		Calendar cal = Calendar.getInstance();
		String str = date.substring(0, 4)+"-"+ date.substring(4, 6)+"-"+date.substring(6)+"T"+cal.get(Calendar.HOUR_OF_DAY)+":"+cal.get(Calendar.MINUTE)+":"+cal.get(Calendar.SECOND);
		model.addAttribute("cal", str);
		return "todo/create";
	}
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String createDo(@ModelAttribute("todo") ToDo todo, BindingResult result, @RequestParam("endTime") String endTime, Model model) {
		System.out.println(endTime);
		todo.setEndTime(endTime);
		int re = ts.insert(todo);
		return "redirect:calendar.html";
	}

	@RequestMapping(value = "detail")
	public String detail(@RequestParam("id") String id, Model model) {
		ToDo todo = ts.detail(id);
		model.addAttribute("todo", todo);
		return "todo/detail";
	}
	@RequestMapping(value = "modify", method = RequestMethod.GET)
	public String modifyForm(@RequestParam("id") String id, Model model) {
		ToDo todo = ts.detail(id);
		todo.setEndTime(todo.getEndTime().replaceAll(" ", "T"));
		model.addAttribute("todo", todo);
		return "todo/modify";
	}
	@RequestMapping(value = "modify", method = RequestMethod.POST)
	public String modify(@ModelAttribute("todo") ToDo todo, BindingResult result, @RequestParam("endTime") String endTime, Model model) {
		todo.setEndTime(endTime);
		System.out.println(todo.toString());
		int re = ts.update(todo);
		return "redirect:calendar.html";
	}
	@RequestMapping(value = "delete")
	public String createForm(@RequestParam("id") String id, Model model) {
		int result = ts.del(id);
		return "redirect:calendar.html";
	}
}
