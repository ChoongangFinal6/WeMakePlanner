package service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import model.CalWithToDo;
import model.ToDoDto;

public interface ToDoService {
	HashMap<String, List<ToDoDto>> startTotal(Calendar fDay, String email);

	HashMap<String, List<ToDoDto>> endTotal(Calendar fDay, String email);

	int insert(ToDoDto todo);

	ToDoDto detail(String id, String email);

	int del(String id,String email);

	int update(ToDoDto todo);

	int toggle(String id,String email);

	int updateEndTime(ToDoDto todo);

	int updateDuration(ToDoDto todo);

	List<ToDoDto> thisWeek(String string);

	ArrayList<CalWithToDo> makeCal(Calendar firstSunDay, Calendar lastSatDay, HashMap<String, List<ToDoDto>> todo, HashMap<String, List<ToDoDto>> todoS);
	
	String makeMail(Date dateAfter, ArrayList<ToDoDto> thisWeek);
}
