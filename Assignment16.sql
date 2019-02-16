---1.  Create a nonclusterd index for the enter_datecolumn of the works_ontable. Sixty percent of each index leaf page should be filled

CREATE NONCLUSTERED INDEX IX_Works_on_Enter_date
    ON DBO.works_on(Enter_date)  WITH(FILLFACTOR =60); 
    
--2. Create a unique composite index for the l_nameand f_namecolumns of the employeetable

CREATE NONCLUSTERED INDEX IX_EMPLOYEE_COMPOSITE_LNAMEandFNAME 
on DBO.employee (emp_lname,emp_fname) ;


--3. Create a view that  comprises the data of all employees that work for the department d1

CREATE VIEW EmployeeDepartmentD1 AS 
SELECT DepartmentID,Location,emp_fname,emp_lname FROM DEPARTMENT INNER JOIN EMPLOYEE ON
 DEP_Id=DepartmentID WHERE  DEP_Id='d1'


--4. For the project table, create a view that can be used by employees who are allowed to view all data of this table except the budgetcolumn

CREATE VIEW PROJECTINFO AS

SELECT PROJECT_NO,PROJECT_NAME FROM PROJECT

-- 5. Create a vew that comprises the first and last names of all employees who entered heir projects in the second half of the year 1988

CREATE VIEW EmployeeWorksInfoAfter19889 as
SELECT Emp_Fname as f_name,Emp_lname as l_name FROM Employee INNER JOIN
WOrks_on ON Emp_no = EmployeeId WHERE enter_date >= '1988-06-30'

-- 6. Solve the previous exercise so that the original columns f_nameand l_name have new names in the view: firstand last, respectively

ALTER VIEW EmployeeWorksInfoAfter19889 as
SELECT Emp_Fname as first ,Emp_lname as last FROM Employee INNER JOIN
WOrks_on ON Emp_no = EmployeeId WHERE enter_date >= '1988-06-30'


-- 7. use the view in Exercise 3 to display full details of all employees whose last names begin with the letter M

SELECT * FROM EmployeeDepartmentD1 where emp_lname like 'M%'

--8 Create a view which comprises full details of all projects on which the employee named smith works

CREATE VIEW EmployeeSmithWorks as
SELECT emp_no,Project_no, Job, enter_date,emp_fname,emp_lname,dep_id 
FROM works_on INNER JOIN Employee on EmployeeId=emp_no WHERE   emp_lname='Smith'




-- 9 Using the ALTER VIEW statement, modify the condition in the view in Exercise-3. The modified view should comprise the data of all employees that work either for the department d1 or d2, or both

ALTER VIEW EmployeeDepartmentD1 AS 
SELECT DepartmentID,Location,emp_fname,emp_lname FROM DEPARTMENT 
INNER JOIN EMPLOYEE ON DEP_Id=DepartmentID WHERE  DEP_Id in ('d1' ,'d2') 


--10. Using the view from Exercise 4, insert details of a new project with project no ‘p2’ andname ‘moon’

INSERT INTO  PROJECTINFO (PROJECT_NO,PROJECT_NAME ) VALUES ('p2','Moon');

--11 Create a view( with the WITH CHECK OPTION clause) that comprises the first and last names of all employees whose employee number is less than 10,000. After that, use he view to insert data for a new employee named Kohn with the employee number 22123, who works for the department d3

Create view EmployeeViewIDLessThan10000 as

select EmployeeID,emp_fname,emp_lname,dep_id from employee where employeeId<10000 WITH CHECK OPTION;



INSERT INTO EmployeeViewIDLessThan10000(EmployeeID,emp_fname,emp_lname,dep_id ) VALUES (22123,'Kohn','K','d3')


-- 12 Create a view(with the WITH CHECK OPTION clause) with full etails from the works_ontable for all employees that entered their projects during the years 1998 and 1999. After that, modify the entering date of the employee with the employee number 19346. The new date is 06/01/1997
create view worksOnSpecificYear as 
SELECT emp_no,project_no,job,enter_date FROM works_on 
where year(enter_date) between 1998 and 1999 with check option;

Update worksOnSpecificYear Set enter_date='06-01-1997' where emp_no=19346



-- 13 Solve the above excersise without the WITH CHECK OPTION clause and find the differences in relation to the modification of the data

create view worksOnSpecificYear1 as 
SELECT emp_no,project_no,job,enter_date FROM works_on 
where year(enter_date) between 1998 and 1999;

Update worksOnSpecificYear1 Set enter_date='06-01-1997' where emp_no=19346;

