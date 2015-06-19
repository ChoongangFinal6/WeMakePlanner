package controller;

import java.util.Calendar;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ToDoController {
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
		
		if (y != "" || y != null ) {
			cal.set(Calendar.YEAR, Integer.parseInt(y));
		}
		if (m != "" || m != null ) {
			cal.set(Calendar.MONTH, Integer.parseInt(m));
		}
		cal.set(Calendar.DATE, 1);
		return "todo/calendar";
	}


}
 