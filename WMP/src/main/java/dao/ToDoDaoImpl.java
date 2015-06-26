package dao;

import java.io.IOException;
import java.io.Reader;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import model.ToDo;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.common.resources.Resources;

@Repository("td")
public class ToDoDaoImpl implements ToDoDao {
	@Autowired
	private SqlSession getSession() throws IOException {
		String src = "mybatis/configuration.xml";
		Reader reader = Resources.getResourceAsReader(src);
		SqlSessionFactory ssf = new SqlSessionFactoryBuilder().build(reader);
		SqlSession session = ssf.openSession(true);
		return session;
	}

	/**
	 * 1일기준 변수를 받아, 해당 월의 시작주 일요일, 마지막주 토요일까지 쿼리 실행 이메일은 임의 입력
	 * 
	 * @param fDay
	 * @return
	 * 
	 */
	@Override
	public HashMap<Integer, List<ToDo>> startTotal(Calendar fDay) {
		HashMap<Integer, List<ToDo>> hms = new HashMap<Integer, List<ToDo>>();
		ToDo todo = new ToDo();
		SqlSession session = null;
		// 시작주 일요일
		Calendar fSun = Calendar.getInstance();
		fSun.set(fDay.get(Calendar.YEAR), fDay.get(Calendar.MONTH), fDay.get(Calendar.DATE));
		fSun.add(Calendar.DATE, +1 - fSun.get(Calendar.DAY_OF_WEEK));
		// 마지막주 토요일 : 말일을 구하고 말일의 요일을 이용하여 더함
		Calendar lSat = Calendar.getInstance();
		lSat.set(fDay.get(Calendar.YEAR), fDay.get(Calendar.MONTH), fDay.getActualMaximum(Calendar.DATE));
		lSat.add(Calendar.DATE, 6-lSat.get(Calendar.DAY_OF_WEEK));
		todo.setEmail("kheeuk@gmail.com");
		int ymd;
		wt: while (true) {
			List<ToDo> dayStart = new ArrayList<ToDo>();
			todo.setStartDateFromCal(fSun);
			todo.setStartTime(new Timestamp(fSun.getTimeInMillis()));
			try {
				session = getSession();
				dayStart = session.selectList("startAll", todo);
			} catch (Exception e) {
			} finally {
				session.close();
			}
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
			fSun.add(Calendar.DATE, +1);
			if (fSun.after(lSat))
				break wt;
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
	public HashMap<Integer, List<ToDo>> endTotal(Calendar fDay) {
		HashMap<Integer, List<ToDo>> hme = new HashMap<Integer, List<ToDo>>();
		ToDo todo = new ToDo();
		SqlSession session = null;
		// 시작주 일요일
		Calendar fSun = Calendar.getInstance();
		fSun.set(fDay.get(Calendar.YEAR), fDay.get(Calendar.MONTH), fDay.get(Calendar.DATE));
		fSun.add(Calendar.DATE, +1 - fSun.get(Calendar.DAY_OF_WEEK));
		// 마지막주 토요일 : 말일을 구하고 말일의 요일을 이용하여 더함
		Calendar lSat = Calendar.getInstance();
		lSat.set(fDay.get(Calendar.YEAR), fDay.get(Calendar.MONTH), fDay.getActualMaximum(Calendar.DATE));
		lSat.add(Calendar.DATE, 6-lSat.get(Calendar.DAY_OF_WEEK));
		// todo.setEndTime(todo.getEndDate());
		todo.setEmail("kheeuk@gmail.com");
		int ymd;
		wt: while (true) {
			List<ToDo> dayEnd = new ArrayList<ToDo>();
			todo.setEndDateFromCal(fSun);
			// todo.setEndTime(new Timestamp(fSun.getTimeInMillis()));
			try {
				session = getSession();
				dayEnd = session.selectList("endAll", todo);
			} catch (Exception e) {
			} finally {
				session.close();
			}
			ymd = Integer.parseInt(String.format("%04d", fSun.get(Calendar.YEAR))
					+ String.format("%02d", fSun.get(Calendar.MONTH) + 1)
					+ String.format("%02d", fSun.get(Calendar.DATE)));
			if (dayEnd.size() > 0) {
				hme.put(ymd, dayEnd);
			}
			fSun.add(Calendar.DATE, +1);
			if (fSun.after(lSat))
				break wt;
		}
		return hme;
	}

	@Override
	public int insert(ToDo todo) {
		SqlSession session = null;
		int result = 0;
		try {
			session = getSession();
			result = session.insert("create", todo);
			System.out.println(result);
		} catch (IOException e) {
			System.out.println("insert Error : " + e.getMessage());
		} finally {
			session.close();
		}
		return result;
	}

	@Override
	public ToDo detail(String id) {
		SqlSession session = null;
		ToDo todo = null;
		try {
			session = getSession();
			todo = session.selectOne("detail", id);
		} catch (IOException e) {
			System.out.println("detail Error : " + e.getMessage());
		} finally {
			session.close();
		}
		return todo;
	}

	@Override
	public int del(String id) {
		SqlSession session = null;
		int result = 0;
		try {
			session = getSession();
			result = session.delete("delete", id);
		} catch (IOException e) {
			System.out.println("detail Error : " + e.getMessage());
		} finally {
			session.close();
		}
		return result;
	}

	@Override
	public int modify(ToDo todo) {
		SqlSession session = null;
		int result = 0;
		try {
			session = getSession();
			result = session.update("update", todo);
		} catch (IOException e) {
			System.out.println("update Error : " + e.getMessage());
		} finally {
			session.close();
		}
		return result;
	}

	@Override
	public int toggle(String id) {
		SqlSession session = null;
		int result = 0;
		try {
			session = getSession();
			String yn = (String)session.selectOne("toggleS", id);
			if (yn.equals("N")) {
				result += session.update("toggleY", id);
				ToDo todo = session.selectOne("detail", id);
				if (todo.getRepeat()>0) {
					todo.setFinish("N");
					result += session.insert("repeat", todo);
				}
			} else {
				result = session.update("toggleN", id);
			}
		} catch (IOException e) {
			System.out.println("update Error : " + e.getMessage());
		} finally {
			session.close();
		}
		return result;
	}

	@Override
	public int updateEndTime(ToDo todo) {
		int result = 0;
		SqlSession session = null;
		try {
			session = getSession();
			result = session.update("updateE", todo);
			
		} catch (IOException e) {
			System.out.println("update Error : " + e.getMessage());
		} finally {
			session.close();
		}
		return result;
	}

	@Override
	public int updateDuration(ToDo todo) {
		int result = 0;
		SqlSession session = null;
		try {
			session = getSession();
			result = session.update("updateD", todo);
			
		} catch (IOException e) {
			System.out.println("update Error : " + e.getMessage());
		} finally {
			session.close();
		}
		return result;
	}
}
