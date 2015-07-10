package service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import model.ToDoDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ToDoDao;
@Service
public class ToDoServiceImpl implements ToDoService {
	@Autowired
	private ToDoDao td;
	
	@Override
	public HashMap<Integer, List<ToDoDto>> startTotal(Calendar fDay, String email) {
		return td.startTotal(fDay, email);
	}
	@Override
	public HashMap<Integer, List<ToDoDto>> endTotal(Calendar fDay, String email) {
		return td.endTotal(fDay, email);
	}
	@Override
	public int insert(ToDoDto todo) {
		return td.insert(todo);
	}
	@Override
	public ToDoDto detail(String id, String email) {
		return td.detail(id, email);
	}
	@Override
	public int del(String id, String email) {
		return td.del(id, email);
	}
	@Override
	public int update(ToDoDto todo) {
		// TODO Auto-generated method stub
		return td.modify(todo);
	}
	@Override
	public int toggle(String id, String email) {
		// TODO Auto-generated method stub
		return td.toggle(id, email);
	}
	@Override
	public int updateEndTime(ToDoDto todo) {
		// TODO Auto-generated method stub
		return td.updateEndTime(todo);
	}
	@Override
	public int updateDuration(ToDoDto todo) {
		// TODO Auto-generated method stub
		return td.updateDuration(todo);
	}
	@Override
	public List<ToDoDto> thisWeek(String string) {
		// TODO Auto-generated method stub
		return td.thisWeek(string);
	}
	
}
