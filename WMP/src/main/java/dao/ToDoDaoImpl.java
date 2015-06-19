package dao;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import model.ToDo;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.ibatis.common.resources.Resources;

@Repository("td")
public class ToDoDaoImpl implements ToDoDao {
	private SqlSession getSession() throws IOException {
		String src = "mybatis/configuration.xml";
		Reader reader = Resources.getResourceAsReader(src);
		SqlSessionFactory ssf = 
			new SqlSessionFactoryBuilder().build(reader);
		SqlSession session = ssf.openSession(true);
		return session;
	}
	
	/**
	 * 1일기준 변수를 받아, 해당 월의 시작주 일요일, 마지막주 토요일까지 쿼리 실행
	 * 이메일은 임의 입력
	 * @param fDay
	 * @return
	 * 
	 */
	@Override
	public HashMap<Integer, ArrayList<ToDo>> startTotal(Calendar fDay) {
		HashMap<Integer, ArrayList<ToDo>> hms = new HashMap<Integer, ArrayList<ToDo>>();
		ToDo todo = null;
		SqlSession session = null;
		
		//시작주 일요일
		Calendar fSun = Calendar.getInstance();
		fSun.set(fDay.YEAR,fDay.MONTH,fDay.DATE);
		fSun.add(Calendar.DATE, +1 - fSun.get(Calendar.DAY_OF_WEEK));
		
		//마지막주 토요일
		Calendar lSat = Calendar.getInstance();
		lSat.set(lSat.YEAR,lSat.MONTH,lSat.getActualMaximum(Calendar.DATE));
		
		todo.setStartDate(fSun);
		todo.setStartTime(todo.getStartTime());
		todo.setEmail("kheeuk@gmail.com");
	
		int ymd;
		wt: while (true) {
			ArrayList<ToDo> dayStart = session.selectList("listAll",ToDo);	
//			dYear = fSun.get(Calendar.YEAR);
//			dDate = fSun.get(Calendar.DATE);
//			dDayW = fSun.get(Calendar.DAY_OF_WEEK);
//			dMonth = fSun.get(Calendar.MONTH) + 1;
//			dDay = fSun.get(Calendar.DAY_OF_MONTH);
			ymd = Integer.parseInt(String.format("%04d", fSun.get(Calendar.YEAR))
					+ String.format("%02d", fSun.get(Calendar.MONTH) + 1)
					+ String.format("%02d", fSun.get(Calendar.DATE)));
		}
		
		
		
//		try {
//			session = getSession();
//			list = session.selectList("listAll",board);
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		} finally { session.close(); }
//		return list;
		return hms;
	}

	@Override
	public HashMap<Integer, ArrayList<ToDo>> endTotal(Calendar fDay) {
		HashMap<Integer, ArrayList<ToDo>> hme = new HashMap<Integer, ArrayList<ToDo>>();
		return hme;
	}
	
}
