select * from todo where endTime = '15-06-18';
select * from todo where TRUNC(endTime) = TO_DATE('2015-06-18','yyyy-mm-dd');

select * from todo where email='kheeuk@gmail.com' and TRUNC(endTime) = TO_DATE('2015-06-18','yyyy-mm-dd') order by endTime asc;
select * from todo;
select * from todo where email='kheeuk@gmail.com' and TRUNC(endTime) = TO_DATE('20150618','yyyymmdd');

select * from todo where email='kheeuk@gmail.com' and TRUNC(endTime-duration) = '2015-06-18';