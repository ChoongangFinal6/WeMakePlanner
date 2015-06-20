package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

public interface ToDoService {
	List<HashMap<Integer, ArrayList<ToDo>>> totalList();
	
}
