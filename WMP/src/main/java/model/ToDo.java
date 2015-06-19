package model;

import java.sql.Timestamp;
import java.util.Calendar;

public class ToDo {
	private int no;					// 일련번호         
	private String title, email;    // 제목           
	private int duration;           // 이메일/아이디      
	private Timestamp endTime;      // 기간           
	private String location;        // 마감시간         
	private Boolean finish;         // 장소           
	private int repeat;             // 완료
	private Timestamp startTime;	// 시작시간 , DB컬럼 x , 마감시간-duration 으로 계산용도
	
	private Calendar startDate, EndDate;	//sql검색중 필요 변수, 1일추가 용의한 calendar 사용
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public Timestamp getEndTime() {
		return endTime;
	}
	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public Boolean getFinish() {
		return finish;
	}
	public void setFinish(Boolean finish) {
		this.finish = finish;
	}
	public int getRepeat() {
		return repeat;
	}
	public void setRepeat(int repeat) {
		this.repeat = repeat;
	}
	public Timestamp getStartTime() {
		return startTime;
	}
	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}
	public Calendar getStartDate() {
		return startDate;
	}
	public void setStartDate(Calendar startDate) {
		this.startDate = startDate;
	}
	public Calendar getEndDate() {
		return EndDate;
	}
	public void setEndDate(Calendar endDate) {
		EndDate = endDate;
	}
	 
}
