package model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * no : int형식 일련번호, 안에서 사용의 편의를 위해 string를 쓸 땐 id로 사용
 * @author 402-d1
 *	
 */
public class ToDo {
	private int no;					// 일련번호         
	private String title, email;    // 제목, 이메일         
	private int duration;           // 기간     
	private String endTime;      // 마감시간        
	private String location;        // 장소      
	private String finish;         //  완료      
	private int repeat;             // 반복
	private Timestamp startTime;	// 시작시간 , DB컬럼 x , 마감시간-duration 으로 계산용도
	
	private String startDate, endDate;	//sql검색중 필요 변수, 1일추가 용의한 calendar 사용, from calendar 사용
	private String finishKey;		// sql에서 토글 기능에 사용
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


	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}

	public String getFinish() {
		return finish;
	}
	public void setFinish(String finish) {
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

	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	//Calendar형에서 직접 set
	public void setStartDateFromCal(Calendar startDate) {
		this.startDate = new SimpleDateFormat("yyyy-MM-dd").format(startDate.getTime());
	}
	public void setEndDateFromCal(Calendar endDate) {
		this.endDate = new SimpleDateFormat("yyyy-MM-dd").format(endDate.getTime());
	}
	
	public String getFinishKey() {
		return finishKey;
	}
	public void setFinishKey(String finishKey) {
		this.finishKey = finishKey;
	}
	public ToDo() {
		super();
	}
	public ToDo(int no, String title, String email, int duration, String endTime, String location,
			String finish, int repeat, Timestamp startTime, String startDate, String endDate) {
		super();
		this.no = no;
		this.title = title;
		this.email = email;
		this.duration = duration;
		this.endTime = endTime;
		this.location = location;
		this.finish = finish;
		this.repeat = repeat;
		this.startTime = startTime;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	@Override
	public String toString() {
		return "ToDo [no=" + no + ", title=" + title + ", email=" + email + ", duration=" + duration
				+ ", endTime=" + endTime + ", location=" + location + ", finish=" + finish + ", repeat="
				+ repeat + ", startTime=" + startTime + ", startDate=" + startDate + ", endDate=" + endDate
				+ "]";
	}

	 
}
