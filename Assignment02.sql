create database sunbeam_db;
use sunbeam_db;

create table user(
email varchar(20) ,
password varchar(20),
role enum('admin','student')
);
alter table user
add constraint fk1 foreign key (email) references students(email);

create table students(
reg_no int primary key,
name varchar(20),
email varchar(20),
course_id int,
mobile_no int,
profile_pic blob
);
alter table students
add unique(email), add constraint fk2 foreign key(course_id) references courses(course_id);
alter table students
add unique(mobile_no);

create table courses(
course_id int primary key,
course_name varchar(20),
discription varchar(20),
fees int,
start_date date,
end_date date,
video_expire_days int
);


create table videos(
video_id int primary key,
course_id int,
title varchar(20),
discription varchar(20),
youtube_url varchar(30),
added_at date
);
alter table videos
add constraint fk3 foreign key(course_id) references courses(course_id);

insert into user(email,password,role)
values('s1',12389,'student'),
		('s2',12389,'student'),
        ('s3',12389,'student');


insert into students (reg_no,name,email,course_id,mobile_no,profile_pic)
values(1,'student1','s1',1,123456,0101111),
		(6,'student2','s2',3,1234567,10011),
		(3,'stusent3','s3',1,1234568,1110001);
        
insert into courses(course_id,course_name,discription,fees,start_date,end_date,video_expire_days)
values(1,'IIT-MERN-2025','MERN',4000,'2025-12-20','2026-1-20',30),
		(7,'AI','COURSE RELATED AI',10000,'2025-12-24','2026-1-24',5),
        (8,'ANDROID','ANDROID COURSE',9999,'2025-12-24','2026-1-24',7),
        (11,'PYTHON','PY',10000,'2025-12-24','2026-1-24',20),
        (3,'IIT-MERN-2025-JULY','MERN',4000,'2025-12-20','2026-1-20',30);
        
        
insert into videos(video_id,course_id,title,discription,youtube_url,added_at)
values(12,1,'mern video 6','MERN','url1','2025-11-26 23:26:18'),
		(14,1,'mern 10','MERN','url2','2025-11-26 23:52:13');
        
select *from courses;
select *from user;
select *from students;
select *from videos;
update courses set start_date='2025-12-10' where course_id=3;



-- Q1. Write a Sql query that will fetch all upcoming courses.

select * from courses where start_date>'2025-12-12';


--  Q2. Write a Sql query that will fetch all the registered students along with course name


select reg_no,name,email,mobile_no,course_id,course_name from students natural join courses;



-- Q3. Write an SQL query to fetch the complete details of a student (based on their email) along with the details of the course they are enrolled in.

select * from students natural join courses where email='s1';



-- Q4 Write an SQL query to retrieve the course details and the list of non-expired videos for a specific student
--    using their email address. A video is considered active (not expired) if its added_at date plus the course’s
--    video_expire_days has not yet passed compared to the current date



select course_id,course_name,start_date,end_date,video_expire_days,video_id,title,added_at 
from courses natural join videos natural join students  where email='s1' and date_add(added_at,INTERVAL video_expire_days day)>= curdate();



