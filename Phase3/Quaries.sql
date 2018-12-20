drop table Invention_management;

create table Inventions(
	invention_id varchar(10) primary key,
	invention_name varchar(20),
	story varchar(100),
	year_invention date,
	invention_category varchar(100));

create table Inventor(
	inventor_id varchar(10) primary key,
	F_name varchar(10),
	L_name varchar(10),
	DOB date,
	job_type varchar(20),
	area varchar(10),
	city varchar(10),
	pincode varchar(10));

alter table Awards ALTER COLUMN award_name  TYPE varchar(40);


create table Awards(
	award_id varchar(10) primary key,
	award_name varchar(40),
	significance varchar(50),
	award_category varchar(20),
	jury_id varchar(10),
	foreign key (jury_id) references Jury);

create table Award_nominations(
	invention_id varchar(10), 
	award_id varchar(10),
	year_of_nomination int,
	primary key(invention_id, award_id),
	foreign key (invention_id) references Inventions,
	foreign key (award_id) references Awards);



create table Jury(
	jury_id varchar(10) primary key,
	jury_name varchar(20),
	start_year int,
	end_year int);


create table Invention_management(
invention_id varchar(10),
award_id varchar(10),
inventor_id varchar(10),
primary key (invention_id, inventor_id, award_id),
foreign key (invention_id) references Inventions,
foreign key (inventor_id) references Inventor,
foreign key (award_id) references Awards);



INSERT INTO Inventions VALUES ('Inv001','Autonomous Cars','ABC','26-MAR-2000','Autonomous Systems');
INSERT INTO Inventions VALUES ('Inv002','Automatic Web Design','DEF','12-JUL-2011','Automation of design');
INSERT INTO Inventions VALUES ('Inv003','Text Understanding','GHI','26-MAR-2010','Text Understanding');
INSERT INTO Inventions VALUES ('Inv004','Autonomous Cars','JKL','26-MAR-2006','Autonomous Systems');
INSERT INTO Inventions VALUES ('Inv005','Adobe XD','MNO','26-MAR-2008','Development Tools');

select * from Inventions;

INSERT INTO Inventor VALUES ('Inr001','Andrej ','Karpathy','13-JUL-1987','Scientist','1','2','3');
INSERT INTO Inventor VALUES ('Inr002','Jeffery ','Hinton','25-FEB-1988','Scientist','a','b','c');
INSERT INTO Inventor VALUES ('Inr003','Siraj ','Raval','17-MAY-1975','Scientist','4','5','6');
INSERT INTO Inventor VALUES ('Inr004','Venu ','Vardhan','28-JUL-1998','Student','d','e','f');
INSERT INTO Inventor VALUES ('Inr005','Srinivas ','Machiraju','19-FEB-1998','Student','7','8','9');
INSERT INTO Inventor VALUES ('Inr006','Vinay ','Varma','18-SEP-1999','Student','g','h','i');
INSERT INTO Inventor VALUES ('Inr007','Jared ','Spool','01-MAY-1987','Scientist','10','11','12');
INSERT INTO Inventor VALUES ('Inr008','Satya ','Pramod','16-DEC-1998','Student','j','k','l');


INSERT INTO Jury VALUES ('Jr001','Suresh Patel',2000,2001);
INSERT INTO Jury VALUES ('Jr002','Ramesh Saxena',2011,2012);
INSERT INTO Jury VALUES ('Jr003','Mike Rooney',2010,2011);
INSERT INTO Jury VALUES ('Jr004','Kritika Singh',2006,2007);
INSERT INTO Jury VALUES ('Jr005','Donald Lee',2008,2009);
INSERT INTO Jury VALUES ('Jr006','Harsh Dwivedi',2008,2009);



INSERT INTO Awards VALUES ('Aw001','Breakthrough Autonomous Systems','Self-Driving','Autonomous Systems','Jr001');
INSERT INTO Awards VALUES ('Aw002','Best Automating Technology','Automation','Automation of design','Jr002');
INSERT INTO Awards VALUES ('Aw003','The Best Software for Text Understanding','Text Understanding','Text Understanding','Jr003');
INSERT INTO Awards VALUES ('Aw004','The Best Potential Future Technology','Self-Driving','Autonomous Systems','Jr004');
INSERT INTO Awards VALUES ('Aw005','Best Tool For Development','Developing Tool','Development Tools','Jr005');
INSERT INTO Awards VALUES ('Aw006','Peoples Choice Best Tool','Developing Tool','Development Tools','Jr006');



select * from Award_nominations;

INSERT INTO Award_nominations VALUES ('Inv001','Aw001',2001);
INSERT INTO Award_nominations VALUES ('Inv001','Aw002',2000);
INSERT INTO Award_nominations VALUES ('Inv001','Aw004',2002);
INSERT INTO Award_nominations VALUES ('Inv002','Aw002',2011);
INSERT INTO Award_nominations VALUES ('Inv002','Aw004',2012);
INSERT INTO Award_nominations VALUES ('Inv002','Aw005',2013);
INSERT INTO Award_nominations VALUES ('Inv003','Aw003',2012);
INSERT INTO Award_nominations VALUES ('Inv003','Aw005',2010);
INSERT INTO Award_nominations VALUES ('Inv003','Aw006',2011);
INSERT INTO Award_nominations VALUES ('Inv004','Aw004',2006);
INSERT INTO Award_nominations VALUES ('Inv004','Aw002',2008);
INSERT INTO Award_nominations VALUES ('Inv004','Aw001',2010);
INSERT INTO Award_nominations VALUES ('Inv005','Aw005',2009);
INSERT INTO Award_nominations VALUES ('Inv005','Aw006',2010);


INSERT INTO Invention_management VALUES ('Inv001','Aw001','Inr001');
INSERT INTO Invention_management VALUES ('Inv001','Aw001','Inr002');
INSERT INTO Invention_management VALUES ('Inv002','Aw002','Inr003');
INSERT INTO Invention_management VALUES ('Inv002','Aw002','Inr004');
INSERT INTO Invention_management VALUES ('Inv003','Aw003','Inr002');
INSERT INTO Invention_management VALUES ('Inv003','Aw003','Inr005');
INSERT INTO Invention_management VALUES ('Inv004','Aw004','Inr001');
INSERT INTO Invention_management VALUES ('Inv004','Aw004','Inr006');
INSERT INTO Invention_management VALUES ('Inv005','Aw005','Inr007');
INSERT INTO Invention_management VALUES ('Inv005','Aw006','Inr007');
INSERT INTO Invention_management VALUES ('Inv005','Aw005','Inr008');
INSERT INTO Invention_management VALUES ('Inv005','Aw006','Inr008');



select count(invention_id) Nominations, year_of_nomination from Award_nominations group by year_of_nomination having count(invention_id)>1;

// Ascending order
SELECT invention_id FROM Inventions ORDER BY (date_part('year', year_invention));


select inventor_id, F_name, L_name from Inventor order by(DOB) DESC;


//join
select * from awards natural join jury;
select * from Invention_management left join Award_nominations on Invention_management.award_id=Award_nominations.award_id;

//How many distict awards each invention got
select count(Distinct(award_id)),invention_id from Invention_management group by invention_id;

//Select Name of inventor where job_type='Scientist' and L_name='Karapathy' or F_name= 'Raval'
select * from Inventor where job_type = 'Scientist' and (L_name = 'Karpathy' or L_name = 'Raval');

// Find age of inventor
SELECT age(DOB) FROM Inventor;


//concatinate Fname and Lname
SELECT concat_ws ('.', F_name, L_name) AS full_name FROM Inventor; 

// Converting DOB to the following format
SELECT to_char(DOB, 'DD/MM/YYYY') from Inventor;

//extract year from year_inventionand invention_id
SELECT EXTRACT(YEAR FROM year_invention), invention_id from Inventions;

// select jury whose time span between 2006 and 2007
SELECT * from Jury where start_year in(2006,2007);


// select inventions whose year_invention not in between 2000 and 2005
SELECT * from Inventions where invention_id in (SELECT invention_id from Inventions where Extract(YEAR FROM year_invention) not between 2000 and 2005);

//Selct inventions which hasnt got nominated for any award
SELECT invention_id from Inventions where invention_id not in (SELECT invention_id from Award_nominations);

SELECT invention_id from Inventions where invention_id in (SELECT invention_id from Award_nominations);

SELECT  invention_id from Inventions intersect select invention_id from Award_nominations;

select distinct(invention_id) from Inventions union select Distinct(invention_id) from Award_nominations;


select  distinct invention_id  from Invention_management where invention_id in (select invention_id from Award_nominations where award_id='Aw001');

select distinct invention_id,award_id from Invention_management where exists (select invention_id, award_id from Award_nominations);
select  distinct invention_id  from Invention_management where invention_id = any(select invention_id from Award_nominations where award_id='Aw004');
select  distinct invention_id  from Invention_management where invention_id = all(select invention_id from Award_nominations where award_id!=null);
