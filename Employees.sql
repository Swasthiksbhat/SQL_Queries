/*SECTION 1 CREATE TABLE STATEMENTS */ 
CREATE TABLE Departments(
    Department_ID INT primary key not null,
    Department_Name VARCHAR(50) not null
);

-- drop table Departments;
-- drop table Employeedetails;
-- drop table EmpSalary;
-- drop table EmpCity;

CREATE TABLE Employeedetails(	
	Employee_ID  INT  primary key not null,
	FirstName  VARCHAR(30) not null,
	LastName  VARCHAR(30) not null,
	Joiningdate  DATE ,
	Department_ID  INT ,
	foreign key (Department_ID) references Departments(Department_ID)
);

CREATE TABLE EmpSalary (
	Employee_ID INT not null,
	Salary DECIMAL(7,2),
	foreign key (Employee_ID) references Employeedetails(Employee_ID)
);

CREATE TABLE EmpCity (
	Employee_ID INT not null,
	City varchar(20) not null,
	foreign key (Employee_ID) references Employeedetails(Employee_ID)
);

/* SECTION 2 INSERT STATEMENTS */
INSERT INTO Departments VALUES('101', 'IT-Software'),
							('102', 'Admin'),
                            ('103', 'HR'),
                            ('104', 'IT-Networking'),
                            ('105', 'Finance'),
                            ('106', 'Marketing'),
                            ('107', 'Sales'),
                            ('108', 'Credit Manager'),
                            ('109', 'Relationship Manager'),
                            ('110', 'Training and Development');
                            
INSERT INTO Employeedetails VALUES('101', 'Omar', 'Abdulla','2018-04-30','101'),
								('102', 'Hamad', 'Mohammed','2019-05-10','101'),
								('103', 'Abdul', 'Rahman','2014-06-15','103'),
                                ('104', 'Mohammed', 'Aziz','2020-10-10','105'),
                                ('105', 'Abdul', 'Aziz','2020-10-03','103'),
                                ('106', 'Mohammed', 'Naib','2019-05-04','105'),
                                ('107', 'Aisha', 'Mohammed','2018-06-30','104'),
                                ('108', 'Nalya', 'Nouf','2017-03-26','101'),
                                ('109', 'Sara', 'Rahman','2015-04-19','110'),
                                ('110', 'Noora', 'Ali','2019-09-30','105'),
                                ('111', 'Lolwa', 'Ahmed','2021-01-02','103'),
                                ('112', 'Abdul', 'Ali','2017-07-30','109'),
                                ('113', 'Hameed', 'Bansal','2020-09-20','107'),
                                ('114', 'Nafique', 'Rahman','2020-02-21','108'),
                                ('115', 'Noora', 'Fathima','2016-02-28','110'),
                                ('116', 'Anisa', 'Ahmed','2019-09-25','109');
                                



INSERT INTO EmpSalary VALUES('101', '50000'),
							('102', '30000'),
                            ('103', '90000'),
                            ('104', '56000'),
                            ('107', '60000'),
                            ('108', '10000'),
                            ('109', '10000'),
                            ('110', '65000'),
                            ('111', '90000'),
                            ('112', '56000'),
                            ('113', '34000'),
                            ('114', '75000'),
                            ('115', '15000'),
                            ('116', '20000');

INSERT INTO EmpCity VALUES('101', 'Doha'),
						('102', 'Dukhan'),
                        ('103', 'Al Khor'),
                        ('104', 'Al Wakrah'),
                        ('105', 'Ar-Rayyan'),
                        ('106', 'Doha'),
                        ('107', 'Al Wakrah'),
                        ('108', 'Doha'),
                        ('109', 'Dukhan'),
                        ('110', 'Dukhan'),
                        ('111', 'Al Wakrah'),
                        ('112', 'Doha'),
                        ('113', 'Al Wakrah'),
                        ('114', 'Ar-Rayyan'),
                        ('115', 'Doha'),
                        ('116', 'Al Khor');


/* SECTION 3 UPDATE STATEMENTS */

UPDATE Employeedetails SET FirstName = 'Abdul', LastName = 'Malik'
WHERE Employee_ID = 104;

UPDATE Employeedetails SET LastName = 'Malik', Joiningdate = '2017-04-23', Department_ID = 102
WHERE Employee_ID = 107;

/* SECTION 4 SINGLE TABLE QUERIES */
/*1. List the names of all Employees whose last name is Mohammed */

select concat(FirstName , ' ' , LastName) as Name
from Employeedetails 
where LastName like 'Mohammed';

/*2. List names of all employees whose second names begin with 'M'. */

select concat(FirstName , ' ' , LastName) as Name 
from Employeedetails 
where LastName like 'M%';

/*3. List names of all employees who are from Doha. */

select concat(E.FirstName ,' ', E.LastName) as Name 
from Employeedetails E inner join EmpCity C
on E.Employee_ID = C.Employee_ID
where City = 'Doha';

/*4. List First names of all employees whose salary is more than 25000 QAR. */

select e.FirstName
from Employeedetails e inner join EmpSalary s
on e.Employee_ID = s.Employee_ID
group by s.Salary
having s.Salary > 25000;

/*5. List name of employees who belongs to 'IT-Software' and from Doha*/

select concat(E.FirstName ,' ', E.LastName) as Name
from Employeedetails E inner join Departments D
	on E.Department_ID = D.Department_ID
		inner join EmpCity C on E.Employee_ID = C.Employee_ID
where Department_Name = 'IT-Software' and City = 'Doha';

 /* SECTION 5 MULTIPLE TABLE QUERIES */


/* 1. List the details of all the employees whose city is Doha */

select *
from Employeedetails
where Employee_ID in (select Employee_ID
				from EmpCity
				where City = 'Doha');

/* 2. List the details of the employees who is from Dukhan and is in IT-Software */
select *
from Employeedetails 
where Employee_ID in (select Employee_ID
					from EmpCity
                    where Department_ID in (select Department_ID
											from Departments
                                            where Department_Name = 'IT-Software'));

/* 3. List the First name, Last name, City name of all the employees */
select FirstName, LastName, City
from Employeedetails E, EmpCity C
where E.Employee_ID = C.Employee_ID
order by City;

/* 4. List all the details of the employees who belongs to IT-Software*/
select *
from Employeedetails e inner join Departments d
	on e.Department_ID = d.Department_ID
where d.Department_Name = 'IT-Software'
group by d.Department_Name;
    
/*5. List the First name, Last name and Date of joining of all the employees who has salary less than 50000 QAR.*/
select FirstName, LastName, Joiningdate
from Employeedetails
where Employee_ID in(select Employee_ID
				from EmpSalary
                where Salary < 50000);



/* SECTION 6 DELETE ROWS (make sure the SQL is commented out in this section)

DELETE FROM Employeedetails WHERE FirstName = 'Aisha';

DELETE FROM Employeedetails WHERE Employee_ID = 108;
*/

/* SECTION 7 DROP TABLES (make sure the SQL is commented out in this section)

drop table Employeedetails;
drop table Departments;
drop table EmpSalary;
drop table EmpCity;

*/
