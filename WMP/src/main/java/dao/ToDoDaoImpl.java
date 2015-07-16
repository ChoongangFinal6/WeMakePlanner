package dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import model.ToDoDto;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("td")
public class ToDoDaoImpl implements ToDoDao {
	@Autowired
	private SqlSession session;

	/**
	 * 1일기준 변수를 받아, 해당 월의 시작주 일요일, 마지막주 토요일까지 쿼리 실행 이메일은 임의 입력
	 * 
	 * @param fDay
	 * @return
	 * 
	 */
	@Override
	public HashMap<Integer, List<ToDoDto>> startTotal(Calendar fDay, String email) {
		HashMap<Integer, List<ToDoDto>> hms = new HashMap<Integer, List<ToDoDto>>();
		ToDoDto todo = new ToDoDto();
		todo.setEmail(email);
		// 시작주 일요일
		Calendar fSun = Calendar.getInstance();
		fSun.set(fDay.get(Calendar.YEAR), fDay.get(Calendar.MONTH), fDay.get(Calendar.DATE));
		fSun.add(Calendar.DATE, +2 - fSun.get(Calendar.DAY_OF_WEEK));
		// 마지막주 토요일 : 말일을 구하고 말일의 요일을 이용하여 더함
		Calendar lSat = Calendar.getInstance();
		lSat.set(fDay.get(Calendar.YEAR), fDay.get(Calendar.MONTH), fDay.getActualMaximum(Calendar.DATE));
		lSat.add(Calendar.DATE, 6 - lSat.get(Calendar.DAY_OF_WEEK));
		int ymd;
		wt: while (true) {
			List<ToDoDto> dayStart = new ArrayList<ToDoDto>();
			todo.setStartDateFromCal(fSun);
			todo.setStartTime(new Timestamp(fSun.getTimeInMillis()));
			dayStart = session.selectList("startAll", todo);
			// dYear = fSun.get(Calendar.YEAR);
			// dDate = fSun.get(Calendar.DATE);
			// dDayW = fSun.get(Calendar.DAY_OF_WEEK);
			// dMonth = fSun.get(Calendar.MONTH) + 1;
			// dDay = fSun.get(Calendar.DAY_OF_MONTH);
			ymd = Integer.parseInt(String.format("%04d", fSun.get(Calendar.YEAR))
					+ String.format("%02d", fSun.get(Calendar.MONTH) + 1)
					+ String.format("%02d", fSun.get(Calendar.DATE)));
			// System.out.println(dayStart.size()+ "ymd : "+ymd);
			if (dayStart.size() > 0) {
				hms.put(ymd, dayStart);
			}
			if (fSun.after(lSat))
				break wt;
			fSun.add(Calendar.DATE, +1);
		}
		// try {
		// session = getSession();
		// list = session.selectList("listAll",board);
		// } catch (Exception e) {
		// System.out.println(e.getMessage());
		// } finally { session.close(); }
		// return list;
		return hms;
	}

	@Override
	public HashMap<Integer, List<ToDoDto>> endTotal(Calendar fDay, String email) {
		HashMap<Integer, List<ToDoDto>> hme = new HashMap<Integer, List<ToDoDto>>();
		ToDoDto todo = new ToDoDto();
		todo.setEmail(email);
		// 시작주 일요일
		Calendar fSun = Calendar.getInstance();
		fSun.set(fDay.get(Calendar.YEAR), fDay.get(Calendar.MONTH), fDay.get(Calendar.DATE));
		fSun.add(Calendar.DATE, +1 - fSun.get(Calendar.DAY_OF_WEEK));
		// 마지막주 토요일 : 말일을 구하고 말일의 요일을 이용하여 더함
		Calendar lSat = Calendar.getInstance();
		lSat.set(fDay.get(Calendar.YEAR), fDay.get(Calendar.MONTH), fDay.getActualMaximum(Calendar.DATE));
		lSat.add(Calendar.DATE, 6 - lSat.get(Calendar.DAY_OF_WEEK));
		// todo.setEndTime(todo.getEndDate());
		int ymd;
		wt: while (true) {
			List<ToDoDto> dayEnd = new ArrayList<ToDoDto>();
			todo.setEndDateFromCal(fSun);
			// todo.setEndTime(new Timestamp(fSun.getTimeInMillis()));
			dayEnd = session.selectList("endAll", todo);
			ymd = Integer.parseInt(String.format("%04d", fSun.get(Calendar.YEAR))
					+ String.format("%02d", fSun.get(Calendar.MONTH) + 1)
					+ String.format("%02d", fSun.get(Calendar.DATE)));
			if (dayEnd.size() > 0) {
				hme.put(ymd, dayEnd);
			}
			if (fSun.after(lSat))
				break wt;
			fSun.add(Calendar.DATE, +1);
		}
		return hme;
	}

	@Override
	public int insert(ToDoDto todo) {
		int result = 0;
		result = session.insert("create", todo);
		return result;
	}

	@Override
	public ToDoDto detail(String id, String email) {
		ToDoDto todoParam = new ToDoDto();
		todoParam.setNo(Integer.parseInt(id));
		todoParam.setEmail(email);
		ToDoDto todo = null;
		todo = session.selectOne("detail", todoParam);
		return todo;
	}

	@Override
	public int del(String id, String email) {
		ToDoDto todoParam = new ToDoDto();
		todoParam.setNo(Integer.parseInt(id));
		todoParam.setEmail(email);
		int result = 0;
		result = session.delete("delete", todoParam);
		return result;
	}

	@Override
	public int modify(ToDoDto todo) {
		int result = 0;
		result = session.update("update", todo);
		return result;
	}

	@Override
	public int toggle(String id, String email) {
		int result = 0;
		ToDoDto todoParam = new ToDoDto();
		todoParam.setNo(Integer.parseInt(id));
		todoParam.setEmail(email);
		String yn = (String)session.selectOne("toggleS", todoParam);
		if (yn.equals("N")) {
			result += session.update("toggleY", todoParam);
			ToDoDto todo = session.selectOne("detail", todoParam);
			if (todo.getRepeat() > 0) {
				todo.setFinish("N");
				result += session.insert("repeat", todo);
			}
		} else {
			result = session.update("toggleN", todoParam);
		}
		return result;
	}

	@Override
	public int updateEndTime(ToDoDto todo) {
		int result = 0;
		result = session.update("updateE", todo);
		return result;
	}

	@Override
	public int updateDuration(ToDoDto todo) {
		int result = 0;
		System.out.println(todo.toString());
		todo.setDuration(session.selectOne("selectDuration",todo));
		result = session.update("updateD", todo);
		return result;
	}

	@Override
	public List<ToDoDto> thisWeek(String string) {
		return (List)session.selectList("thisWeek", string);
	}
}
