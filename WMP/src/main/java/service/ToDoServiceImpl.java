package service;

import java.util.ArrayList;
import java.util.HashMap;

import model.ToDo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ToDoDao;
@Service
public class ToDoServiceImpl implements ToDoService {
	@Autowired
	private ToDoDao td;
	
	@Override
	public HashMap<Integer, ArrayList<ToDo>> startTotal() {
		return td.startTotal();
	}
	@Override
	public HashMap<Integer, ArrayList<ToDo>> endTotal() {
		return td.endTotal();
	}
	
}
