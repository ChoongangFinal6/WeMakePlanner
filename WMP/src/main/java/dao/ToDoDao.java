package dao;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import model.ToDoDto;

public interface ToDoDao {
	HashMap<String, List<ToDoDto>> startTotal(Calendar fDay, String email);

	HashMap<String, List<ToDoDto>> endTotal(Calendar fDay, String email);

	int insert(ToDoDto todo);

	ToDoDto detail(String id, String email);

	int del(String id, String email);

	int modify(ToDoDto todo);

	int toggle(String id, String email);

	int updateEndTime(ToDoDto todo);

	int updateDuration(ToDoDto todo);

	List<ToDoDto> thisWeek(String string);
}
