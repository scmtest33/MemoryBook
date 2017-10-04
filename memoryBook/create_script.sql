--멤버 테이블
create table t_member(
	mem_no number(6) not NULL,
	mem_pwd varchar2(20) not NULL,
	name varchar2(50) not NULL,
	email varchar2(200) not NULL,
	MEM_IMAGE VARCHAR2(1000),
	INFONUMBER varchar2(1) not NULL,
	APPROVALNUM varchar2(1) default 0 not NULL,
	CONSTRAINT MEM_NO PRIMARY KEY(mem_no),
	CONSTRAINT EMAIL UNIQUE (email)
);

--친구 테이블
create table t_friend(
mem_email varchar2(200) not NULL,
friend_email varchar2(200) not NULL,
mem_auth varchar2(1) default 0 not NULL,
CONSTRAINT MEM_EMAIL FOREIGN KEY(mem_email) REFERENCES t_member(email) on delete cascade,
CONSTRAINT FRIEND_EMAIL FOREIGN KEY(friend_email) REFERENCES t_member(email) on delete cascade
);

--카테고리 테이블
create table t_category(
	category_no number(6) primary key,
	mem_no number(6) not NULL,
	category_name varchar2(50) not NULL,
	CONSTRAINT MEM_NO_C FOREIGN KEY(mem_no) REFERENCES t_member(mem_no) on delete cascade
);

--드래그 테이블
create table t_drag(
	drag_no number(6) primary key,
	mem_no number(6) not NULL,
	drag_content varchar2(1000) not NULL,
	drag_url varchar2(1000),
	drag_url_title varchar2(1000),
	drag_reg_date timestamp default SYSDATE,
	drag_update_date timestamp,
	drag_auth varchar2(1) default 0 not NULL,
	CONSTRAINT MEM_NO_D FOREIGN KEY(mem_no) REFERENCES t_member(mem_no) on delete cascade
);

--노트 테이블
create table t_note(
	note_no number(6) primary key,
	mem_no number(6) not NULL,
	category_no number(6) not NULL,
	note_content varchar2(1000) not NULL,
	note_title varchar2(300) not NULL,
	note_reg_date timestamp default SYSDATE,
	note_update_date timestamp,
	note_auth varchar2(1) default 0 not NULL,
	CONSTRAINT MEM_NO_N FOREIGN KEY(mem_no) REFERENCES t_member(mem_no) on delete cascade,
	CONSTRAINT CATEGORY_NO FOREIGN KEY(category_no) REFERENCES t_category(category_no) on delete cascade
);

--마인드맵 테이블
create table T_MINDMAP(
mindnum number(3) constraint T_MINDMAP_mindnum_PK PRIMARY KEY,
mindname varchar2(1000) constraint T_MINDMAP_mindname_NN not null,
mindjson varchar2(4000) constraint T_MINDMAP_mindjson_NN not null,
mem_no number(6) constraint T_MINDMAP_mem_no_FK references T_MEMBER(mem_no) on delete cascade
);

--시퀀스
create sequence mem_no start with 1 increment by 1;
create sequence category_no start with 1 increment by 1;
create sequence drag_no start with 1 increment by 1;
create sequence drag_img_no start with 1 increment by 1;
create sequence note_no start with 1 increment by 1;
create sequence note_img_no start with 1 increment by 1;
CREATE SEQUENCE T_MINDMAP_MINDNUM_seq start with 1 increment by 1;