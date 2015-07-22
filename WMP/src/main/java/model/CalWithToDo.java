package model;

import java.util.List;

public class CalWithToDo {
	private String yymmdd;
	private String mmdd;
	private List<ToDoDto> todoS;
	private List<ToDoDto> todo;
	public String getYymmdd() {
		return yymmdd;
	}
	public void setYymmdd(String yymmdd) {
		this.yymmdd = yymmdd;
	}
	public String getMmdd() {
		return mmdd;
	}
	public void setMmdd(String mmdd) {
		this.mmdd = mmdd;
	}
	public List<ToDoDto> getTodoS() {
		return todoS;
	}
	public void setTodoS(List<ToDoDto> todoS) {
		this.todoS = todoS;
	}
	public List<ToDoDto> getTodo() {
		return todo;
	}
	public void setTodo(List<ToDoDto> todo) {
		this.todo = todo;
	}
	public CalWithToDo() {
		super();
	}
	
}
