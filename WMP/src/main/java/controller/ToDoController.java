package controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.ToDoDao;

@Controller
public class ToDoController {
	@Autowired
	ToDoDao td;
	@RequestMapping(value="calendar")
	public String calendar(String y, String m, Model model) {
		Calendar cal = Calendar.getInstance(); //현재 시스템이 가지고 있는 날짜 데이터 가지고 오기
		int y1, m1;
//		if (y == "" || y == null ) {
//			y1 = cal.get(Calendar.YEAR);
//		} else {
//			y1 = Integer.parseInt(y);
//		}
//		if (m == "" || m == null ) {
//			m1 = cal.get(Calendar.MONTH) + 1;
//		} else {
//			m1 = Integer.parseInt(m);
//		}
//		int d = cal.get(Calendar.DATE);
		
		if (y != null && y != "null" && !y.equals("") ) {
			System.out.println(y);
			cal.set(Calendar.YEAR, Integer.parseInt(y));
		}
		if (m != null && m != "null" && !m.equals("")  ) {
			cal.set(Calendar.MONTH, Integer.parseInt(m));
		}
		cal.set(Calendar.DATE, 1);
		HashMap<Integer, List<ToDo>> todoS = td.startTotal(cal);
		HashMap<Integer, List<ToDo>> todo = td.endTotal(cal);
		model.addAttribute("cal",cal);
		model.addAttribute("todoS",todoS);
		model.addAttribute("todo",todo);
		model.addAttribute("y",y);
		model.addAttribute("m",m);
		model.addAttribute("w",cal.get(Calendar.DAY_OF_WEEK));
		return "todo/calendar";
	}


}
 