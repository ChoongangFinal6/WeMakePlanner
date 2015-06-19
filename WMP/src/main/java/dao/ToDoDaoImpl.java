package dao;

import java.util.ArrayList;
import java.util.HashMap;

import model.ToDo;

import org.springframework.stereotype.Repository;

@Repository("td")
public class ToDoDaoImpl implements ToDoDao {
	@Override
	public HashMap<Integer, ArrayList<ToDo>> startTotal() {
		HashMap<Integer, ArrayList<ToDo>> hms = new HashMap<Integer, ArrayList<ToDo>>();
		ArrayList<ToDo> d20150611 = new ArrayList<ToDo>();
		return hms;
	}

	@Override
	public HashMap<Integer, ArrayList<ToDo>> endTotal() {
		HashMap<Integer, ArrayList<ToDo>> hme = new HashMap<Integer, ArrayList<ToDo>>();
		return hme;
	}
	
}
