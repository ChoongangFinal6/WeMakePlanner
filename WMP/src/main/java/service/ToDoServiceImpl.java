package service;

import java.util.ArrayList;
import java.util.Calendar;
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
	public HashMap<Integer, ArrayList<ToDo>> startTotal(Calendar fDay) {
		return td.startTotal(fDay);
	}
	@Override
	public HashMap<Integer, ArrayList<ToDo>> endTotal(Calendar fDay) {
		return td.endTotal(fDay);
	}
	
}
