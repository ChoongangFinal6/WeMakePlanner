package service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import model.CalWithToDo;
import model.ToDoDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ToDoDao;

@Service
public class ToDoServiceImpl implements ToDoService {
	@Autowired
	private ToDoDao td;

	@Override
	public HashMap<String, List<ToDoDto>> startTotal(Calendar fDay, String email) {
		return td.startTotal(fDay, email);
	}

	@Override
	public HashMap<String, List<ToDoDto>> endTotal(Calendar fDay, String email) {
		return td.endTotal(fDay, email);
	}

	@Override
	public int insert(ToDoDto todo) {
		return td.insert(todo);
	}

	@Override
	public ToDoDto detail(String id, String email) {
		return td.detail(id, email);
	}

	@Override
	public int del(String id, String email) {
		return td.del(id, email);
	}

	@Override
	public int update(ToDoDto todo) {
		// TODO Auto-generated method stub
		return td.modify(todo);
	}

	@Override
	public int toggle(String id, String email) {
		// TODO Auto-generated method stub
		return td.toggle(id, email);
	}

	@Override
	public int updateEndTime(ToDoDto todo) {
		// TODO Auto-generated method stub
		return td.updateEndTime(todo);
	}

	@Override
	public int updateDuration(ToDoDto todo) {
		// TODO Auto-generated method stub
		return td.updateDuration(todo);
	}

	@Override
	public List<ToDoDto> thisWeek(String string) {
		return td.thisWeek(string);
	}

	@Override
	public String makeMail(Date dateAfter, ArrayList<ToDoDto> thisWeek) {
		String result = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		String dateString = sdf.format(dateAfter).toString();
		result += "" + "<title>금주의 일정</title>" +
				"<script type=\"text/javascript\" src=\"http://211.183.2.54:8181/wmp/resources/js/tw.js\"></script>"
				+ "<script type=\"text/javascript\" src=\"http://211.183.2.54:8181/wmp/resources/js/jquery.js\"></script>"
				+
		"<link href=\"http://211.183.2.54:8181/wmp/resources/css/thisWeek.css\" rel=\"stylesheet\"><div id=\"thisWeek\">"
				+ "<div class='top'><span class='topTitle'>한 주의 일정</span><span class='topDate'>~" + dateString
				+ "</span><br>" + "<div id=\"expand\">" + "<a id=\"expandText\">펼치기</a>" + "</div>" + "</div>"
				+ "<div id=\"main\">";
		for (ToDoDto tw : thisWeek) {
			result += "<div class='item'><div class='header'><span class='title'>";
			result += tw.getTitle();
			result += "</span>";
			result += "<span class='dday'>";
			if (tw.getDuration() > 0) {
				result += "D-" + tw.getDuration();
			}
			result += "</span>";
			if (tw.getDuration() > 0) {
				result += "부터 준비";
			}
			result += "</div>";
			result += "<div class='main'><span id='endTime" + tw.getNo() + "'>" + tw.getEndTime();
			result += "</span><br>";
			if (tw.getLocation().length() > 10) {
				result += "<span id='map" + tw.getNo() + "' class='map'> </span>";
			}
			if (tw.getRepeat() > 0) {
				result += "<span id='repeat" + tw.getNo() + "'>" + tw.getRepeat() + "일 마다 반복</span>";
			}
			result += "</div></div>";
		}
		if (thisWeek.size() < 1) {
			result += "<div style='text-align: center;margin-top: 100px;font-size: 1em;'>금주의 일정이 없습니다.</div>";
		}
		result += "</div></div>";
		// result += "</body></html>";
		return result;
	}

	@Override
	public ArrayList<CalWithToDo> makeCal(Calendar firstSunday, Calendar lastSatDay, HashMap<String, List<ToDoDto>> todo,
			HashMap<String, List<ToDoDto>> todoS) {
		String yymmdd;
		int dDate, dDayW, dMonth, dDay, dYear;
		ArrayList<CalWithToDo> list = new ArrayList<>();
		wt: while (true) {
			dYear = firstSunday.get(Calendar.YEAR);
			dDate = firstSunday.get(Calendar.DATE);
			dDayW = firstSunday.get(Calendar.DAY_OF_WEEK);
			dMonth = firstSunday.get(Calendar.MONTH) + 1;
			yymmdd = String.format("%04d", dYear) + String.format("%02d", dMonth) + String.format("%02d", dDate);
			
			lastSatDay.set(Calendar.DAY_OF_MONTH, lastSatDay.getActualMaximum(Calendar.DATE));
			CalWithToDo ctd = new CalWithToDo();
			ctd.setYymmdd(yymmdd);
			ctd.setTodoS(todoS.get(yymmdd));
			ctd.setTodo(todo.get(yymmdd));
			list.add(ctd);
			if (firstSunday.after(lastSatDay) && dDayW == 7) {
				break wt;
			}
			firstSunday.add(Calendar.DATE, +1);
		}
		return list;
	}
}
