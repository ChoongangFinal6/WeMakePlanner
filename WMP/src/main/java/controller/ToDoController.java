package controller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.ToDoDao;

@Controller
public class ToDoController {
	@Autowired
	ToDoDao td;
	@RequestMapping(value="calendar")
	public String calendar(String y, String m, Model model) {
		Calendar cal = Calendar.getInstance(); //현재 시스템이 가지고 있는 날짜 데이터 가지고 오기
		if (y != null && y != "null" && !y.equals("") ) {
			System.out.println(y);
			cal.set(Calendar.YEAR, Integer.parseInt(y));
		}
		if (m != null && m != "null" && !m.equals("")  ) {
			cal.set(Calendar.MONTH, Integer.parseInt(m)-1);
		}
		cal.set(Calendar.DATE, 1);
		HashMap<Integer, List<ToDo>> todo = td.endTotal(cal);
		HashMap<Integer, List<ToDo>> todoS = td.startTotal(cal);
		model.addAttribute("cal",cal);
		model.addAttribute("todoS",todoS);
		model.addAttribute("todo",todo);
		model.addAttribute("y",cal.get(Calendar.YEAR));
		model.addAttribute("m",cal.get(Calendar.MONTH));
		model.addAttribute("w",cal.get(Calendar.DAY_OF_WEEK));
		return "todo/calendar";
	}
	@RequestMapping(value="create", method = RequestMethod.GET)
	public String createForm(String date, Model model) {
		Date dt = new Date();
		Calendar cal = Calendar.getInstance();
		dt.setTime(cal.getTimeInMillis());
		cal.set(Integer.parseInt(date.substring(0, 4)), 
				Integer.parseInt(date.substring(4, 6)),
				Integer.parseInt(date.substring(6)));
		model.addAttribute("cal",dt.toString());
		return "todo/create";
	}
	@RequestMapping(value="create", method = RequestMethod.POST)
	public String createDo(ToDo todo, Model model) {
		td.insert(todo);
		return "todo/create";
	}
}
 