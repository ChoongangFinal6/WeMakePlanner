package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

public interface ToDoDao {
	HashMap<Integer, ArrayList<ToDo>> startTotal();
	HashMap<Integer, ArrayList<ToDo>> endTotal();
}
