package dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import model.ToDo;

public interface ToDoDao {
	HashMap<Integer, ArrayList<ToDo>> startTotal(Calendar fDay);
	HashMap<Integer, ArrayList<ToDo>> endTotal(Calendar fDay);
}
