package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

public interface ToDoDao {
	List<HashMap<Integer, ArrayList<ToDo>>> totalList();
}
