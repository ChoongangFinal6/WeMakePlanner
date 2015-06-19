-- 레시피
DROP TABLE recipe;

-- todo
DROP TABLE todo;

-- partner
DROP TABLE partner;

-- rating
DROP TABLE rating;

-- 댓글
DROP TABLE rTodo;

-- 레시피
CREATE TABLE recipe (
	no          INTEGER       NOT NULL, -- 글번호
	id          INTEGER       NULL,     -- id
	email       VARCHAR2(100) NOT NULL, -- 이메일/아이디
	country     VARCHAR2(50)  NULL,     -- 국가
	time        DATE          NOT NULL, -- 시간
	ingredient1 VARCHAR2(255) NOT NULL, -- 주재료
	ingredient2 VARCHAR2(255) NULL,     -- 부재료
	name        VARCHAR2(255) NOT NULL, -- 요리명
	difficulty  INTEGER       NULL,     -- 난이도
	size        INTEGER       NULL,     -- 인분
	oven        BOOLEAN       NULL      -- 오븐
);

-- 레시피
ALTER TABLE recipe
	ADD
		CONSTRAINT PK_recipe -- 레시피 기본키
		PRIMARY KEY (
			no -- 글번호
		);

-- todo
CREATE TABLE todo (
	no       INTEGER       NOT NULL, -- 일련번호
	title    VARCHAR2(255) NOT NULL, -- 제목
	email    VARCHAR2(100) NOT NULL, -- 이메일/아이디
	duration INTEGER       NULL,     -- 기간
	endTime  DATE          NOT NULL, -- 마감시간
	location VARCHAR2(100) NULL,     -- 장소
	finish   VARCHAR2(1)   NOT NULL DEFAULT 0,     -- 완료
	repeat   INTEGER       NULL      -- 반복
);

-- todo
ALTER TABLE todo
	ADD
		CONSTRAINT PK_todo -- todo 기본키
		PRIMARY KEY (
			no -- 일련번호
		);

-- partner
CREATE TABLE partner (
	no    INTEGER       NOT NULL, -- 일련번호
	email VARCHAR2(100) NULL,     -- 이메일
	phone VARCHAR2(100) NULL,     -- 전화
	time  DATE          NOT NULL  -- 연락시간
);

-- rating
CREATE TABLE rating (
	no    INTEGER       NOT NULL, -- 글번호
	rate  INTEGER       NOT NULL, -- 평점
	email VARCHAR2(100) NOT NULL  -- 이메일/아이디
);

-- rating
ALTER TABLE rating
	ADD
		CONSTRAINT PK_rating -- rating 기본키
		PRIMARY KEY (
			no -- 글번호
		);

-- 댓글
CREATE TABLE rTodo (
	id    INTEGER       NOT NULL, -- id
	no    INTEGER       NOT NULL, -- 글번호
	email VARCHAR2(100) NOT NULL, -- 이메일/아이디
	time  INTEGER       NOT NULL  -- 시간
);

-- 댓글
ALTER TABLE rTodo
	ADD
		CONSTRAINT PK_rTodo -- 댓글 기본키
		PRIMARY KEY (
			id, -- id
			no  -- 글번호
		);

-- 레시피
ALTER TABLE recipe
	ADD
		FOREIGN KEY (
			id -- id
		)
		REFERENCES rTodo ( -- 댓글
			id, -- id
			no  -- 글번호
		)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

-- partner
ALTER TABLE partner
	ADD
		CONSTRAINT FK_todo_TO_partner -- todo -> partner
		FOREIGN KEY (
			no -- 일련번호
		)
		REFERENCES todo ( -- todo
			no -- 일련번호
		)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

-- rating
ALTER TABLE rating
	ADD
		CONSTRAINT FK_recipe_TO_rating -- 레시피 -> rating
		FOREIGN KEY (
			no -- 글번호
		)
		REFERENCES recipe ( -- 레시피
			no -- 글번호
		)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

-- 댓글
ALTER TABLE rTodo
	ADD
		CONSTRAINT FK_recipe_TO_rTodo -- 레시피 -> 댓글
		FOREIGN KEY (
			no -- 글번호
		)
		REFERENCES recipe ( -- 레시피
			no -- 글번호
		)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;
		
CREATE SEQUENCE recipe_no
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 5;
CREATE SEQUENCE todo_no
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 3;
CREATE SEQUENCE rating_no
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 5;
CREATE SEQUENCE rtodo_no
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 3;
CREATE SEQUENCE partner_no
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 3;