package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import model.CalWithToDo;
import model.ToDoDto;
import service.ToDoService;

@Controller
public class ToDoController {
	@Autowired
	ToDoService ts;

	@RequestMapping(value = "calendar")
	public String calendar(String y, String m, Model model, HttpSession session) {
		session.setAttribute("email", "kheeuk1@gmail.com");
		String email = session.getAttribute("email").toString();
		Calendar cal = Calendar.getInstance(); // 현재 시스템이 가지고 있는 날짜 데이터 가지고 오기
		if (y != null && y != "null" && !y.equals("")) {
			cal.set(Calendar.YEAR, Integer.parseInt(y));
		}
		if (m != null && m != "null" && !m.equals("")) {
			cal.set(Calendar.MONTH, Integer.parseInt(m) - 1);
		}
		cal.set(Calendar.DATE, 1);
		HashMap<Integer, List<ToDoDto>> todo = ts.endTotal(cal, email);
		HashMap<Integer, List<ToDoDto>> todoS = ts.startTotal(cal, email);
		
		Calendar day = Calendar.getInstance();
		day.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE));
		day.add(Calendar.DATE, +1 - cal.get(Calendar.DAY_OF_WEEK));
		
		CalWithToDo ctd = ts.makeCal(day, todo, todoS);
		model.addAttribute("cal", cal);
		model.addAttribute("todoS", todoS);
		model.addAttribute("todo", todo);
		model.addAttribute("ctd", ctd);
		model.addAttribute("y", cal.get(Calendar.YEAR));
		model.addAttribute("m", cal.get(Calendar.MONTH));
		model.addAttribute("w", cal.get(Calendar.DAY_OF_WEEK));
		return "todo/calendar";
	}

	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(@ModelAttribute("todo") ToDoDto todo, BindingResult result, String date, Model model) {
		Calendar cal = Calendar.getInstance();
		String str = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6) + "T"
				+ String.format("%02d", cal.get(Calendar.HOUR_OF_DAY)) + ":"
				+ String.format("%02d", cal.get(Calendar.MINUTE)) + ":"
				+ String.format("%02d", cal.get(Calendar.SECOND));
		model.addAttribute("cal", str);
		return "todo/create";
	}

	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String createDo(@ModelAttribute("todo") ToDoDto todo, BindingResult result,
			@RequestParam("endTime") String endTime, Model model, HttpSession session) {
		todo.setEmail(session.getAttribute("email").toString());
		todo.setEndTime(endTime);
		int re = ts.insert(todo);
		return "redirect:calendar.html";
	}

	@RequestMapping(value = "detail")
	public String detail(@RequestParam("id") String id, Model model, HttpSession session) {
		String email = session.getAttribute("email").toString();
		ToDoDto todo = ts.detail(id, email);
		String[] loc = {};
		if (todo.getLocation() != null && todo.getLocation().contains(",")) {
			loc = todo.getLocation().split(",");
		}
		model.addAttribute("todo", todo);
		if (loc.length == 2 && todo.getLocation().length() > 10) {
			model.addAttribute("locX", loc[0].toString());
			model.addAttribute("locY", loc[1].toString());
		}
		return "todo/detail";
	}

	@RequestMapping(value = "modify", method = RequestMethod.GET)
	public String modifyForm(@RequestParam("id") String id, Model model, HttpSession session) {
		String email = session.getAttribute("email").toString();
		ToDoDto todo = ts.detail(id, email);
		todo.setEndTime(todo.getEndTime().replaceAll(" ", "T"));
		model.addAttribute("todo", todo);
		return "todo/modify";
	}

	@RequestMapping(value = "modify", method = RequestMethod.POST)
	public String modify(@ModelAttribute("todo") ToDoDto todo, BindingResult result,
			@RequestParam("endTime") String endTime, Model model, HttpSession session) {
		todo.setEndTime(endTime);
		todo.setEmail(session.getAttribute("email").toString());
		int re = ts.update(todo);
		return "redirect:calendar.html";
	}

	@RequestMapping(value = "delete")
	public String createForm(@RequestParam("id") String id, Model model, HttpSession session) {
		String email = session.getAttribute("email").toString();
		int result = ts.del(id, email);
		return "redirect:calendar.html";
	}

	@RequestMapping(value = "tgl")
	public String toggle(@RequestParam("id") String id, HttpServletRequest req, HttpServletResponse rep,
			Model model, HttpSession session) throws IOException {
		String email = session.getAttribute("email").toString();
		int result = ts.toggle(id, email);
		rep.setContentType("text/html; charset=utf-8");
		PrintWriter out = rep.getWriter();
		out.print(result);
		return null;
	}

	@RequestMapping(value = "updateEndTime")
	public String updateET(@RequestParam("id") String id, @RequestParam("date") String date,
			HttpServletRequest req, HttpServletResponse rep, Model model, HttpSession session) throws IOException {
		String email = session.getAttribute("email").toString();
		int result = 0;
		ToDoDto todo = ts.detail(id, email);
		String str = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6);
		str = str + "T" + todo.getEndTime().substring(11, 19);
		todo.setEndTime(str);
		result = ts.updateEndTime(todo);
		rep.setContentType("text/html; charset=utf-8");
		PrintWriter out = rep.getWriter();
		out.print(todo.getDuration());
		return null;
	}

	@RequestMapping(value = "updateDuration")
	public String updateD(@RequestParam("id") String id, @RequestParam("date") String date, Model model,
			HttpSession session) {
		String email = session.getAttribute("email").toString();
		int result = 0;
		ToDoDto todo = ts.detail(id, email);
		String str = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6);
		str = str + "T" + todo.getEndTime().substring(11, 19);
		todo.setEndTime(str);
		result = ts.updateDuration(todo);
		return "redirect:calendar.html";
	}

	@RequestMapping(value = "map")
	public String map(String locX, String locY, Model model) {
		model.addAttribute("locX", locX);
		model.addAttribute("locY", locY);
		return "todo/map";
	}

	@RequestMapping(value = "mapDetail")
	public String mapDetail(String locX, String locY, Model model) {
		model.addAttribute("locX", locX);
		model.addAttribute("locY", locY);
		return "todo/mapDetail";
	}

	@RequestMapping(value = "thisWeek")
	public String thisWeek(Model model, HttpSession session) {
		String email = session.getAttribute("email").toString();
		ArrayList<ToDoDto> thisWeek = (ArrayList)ts.thisWeek(email);
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 7);
		Date dateAfter = new Date(cal.getTimeInMillis());
		model.addAttribute("thisWeek", thisWeek);
		model.addAttribute("date", date);
		model.addAttribute("dateAfter", dateAfter);
		return "todo/thisWeek";
	}
}
