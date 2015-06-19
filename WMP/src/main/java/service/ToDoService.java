package service;

import java.util.ArrayList;
import java.util.HashMap;

import model.ToDo;

public interface ToDoService {
	HashMap<Integer, ArrayList<ToDo>> startTotal();
	HashMap<Integer, ArrayList<ToDo>> endTotal();
}
