package service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import model.ToDoDto;

public interface ToDoService {
	HashMap<Integer, List<ToDoDto>> startTotal(Calendar fDay, String email);

	HashMap<Integer, List<ToDoDto>> endTotal(Calendar fDay, String email);

	int insert(ToDoDto todo);

	ToDoDto detail(String id, String email);

	int del(String id,String email);

	int update(ToDoDto todo);

	int toggle(String id,String email);

	int updateEndTime(ToDoDto todo);

	int updateDuration(ToDoDto todo);

	List<ToDoDto> thisWeek(String string);
	
	String makeMail(Date dateAfter, ArrayList<ToDoDto> thisWeek);
}
