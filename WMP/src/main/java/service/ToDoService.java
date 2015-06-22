package service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

public interface ToDoService {
	HashMap<Integer, List<ToDo>> startTotal(Calendar fDay);
	HashMap<Integer, List<ToDo>> endTotal(Calendar fDay);
	int insert(ToDo todo);
}
