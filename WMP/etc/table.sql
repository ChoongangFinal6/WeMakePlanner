-- todo
DROP TABLE tododto;

-- todo
CREATE TABLE tododto (
	no       INTEGER       NOT NULL, -- 일련번호
	title    VARCHAR2(255) NOT NULL, -- 제목
	email    VARCHAR2(100) NOT NULL, -- 이메일/아이디
	duration INTEGER       NULL,     -- 기간
	endTime  DATE          NOT NULL, -- 마감시간
	location VARCHAR2(100) NULL,     -- 장소
	finish   VARCHAR2(1)   NOT NULL,     -- 완료
	repeat   INTEGER       NULL      -- 반복
);

-- todo
ALTER TABLE tododto
	ADD
		CONSTRAINT PK_todo -- todo 기본키
		PRIMARY KEY (
			no -- 일련번호
		);

	
CREATE SEQUENCE todo_no
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 3;
