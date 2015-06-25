package service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ToDoDao;
@Service
public class ToDoServiceImpl implements ToDoService {
	@Autowired
	private ToDoDao td;
	
	@Override
	public HashMap<Integer, List<ToDo>> startTotal(Calendar fDay) {
		return td.startTotal(fDay);
	}
	@Override
	public HashMap<Integer, List<ToDo>> endTotal(Calendar fDay) {
		return td.endTotal(fDay);
	}
	@Override
	public int insert(ToDo todo) {
		return td.insert(todo);
	}
	@Override
	public ToDo detail(String id) {
		return td.detail(id);
	}
	@Override
	public int del(String id) {
		return td.del(id);
	}
	@Override
	public int update(ToDo todo) {
		// TODO Auto-generated method stub
		return td.modify(todo);
	}
	@Override
	public int toggle(String id) {
		// TODO Auto-generated method stub
		return td.toggle(id);
	}
	@Override
	public int updateEndTime(ToDo todo) {
		// TODO Auto-generated method stub
		return td.updateEndTime(todo);
	}
	@Override
	public int updateDuration(ToDo todo) {
		// TODO Auto-generated method stub
		return td.updateDuration(todo);
	}
	
}
