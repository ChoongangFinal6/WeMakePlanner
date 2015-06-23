select * from todo where endTime = '15-06-18';
select * from todo where TRUNC(endTime) = TO_DATE('2015-06-18','yyyy-mm-dd');

select * from todo where email='kheeuk@gmail.com' and TRUNC(endTime) = TO_DATE('2015-06-18','yyyy-mm-dd') order by endTime asc;
select * from todo;
select * from todo where email='kheeuk@gmail.com' and TRUNC(endTime) = TO_DATE('20150618','yyyymmdd');

select * from todo where email='kheeuk@gmail.com' and TRUNC(endTime-duration) = '2015-06-18';

insert into todo values (todo_no.nextval, 'dfsadaw', 'kheeuk@gmail.com', 0, to_date('2015-06-06T18:06','yyyy-MM-ddThh24:mi'), '0', '0', 0);

no=0,  email=, duration=0, endTime=, location=, finish=false, repeat=0, startTime=null, startDate=null, endDate=null]