package service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

public interface ToDoService {
	HashMap<Integer, List<ToDo>> startTotal(Calendar fDay);
	HashMap<Integer, List<ToDo>> endTotal(Calendar fDay);
	int insert(ToDo todo);
	ToDo detail(String id);
	int del(String id);
	int update(ToDo todo);
	int toggle(String id);
	int updateEndTime(ToDo todo);
	int updateDuration(ToDo todo);
}
