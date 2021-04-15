--create tables for employee, department, project, can do job title to make it serial  list all attributes from readme
-- link employee table to department, project, job title
-- do table with the least information first
--jobtitle, department, project employee
--can link jobtitle to department
-- 3 jobtitle, 4 projects, 3 departments, 8 employees
-- create a join project_employee table for employee and project dont have to name them


CREATE TABLE jobtitle(
        job_title_id SERIAL NOT NULL,
        job_title VARCHAR (100),
        
        CONSTRAINT pk_job_title_id PRIMARY KEY (job_title_id)
        
        );
        
CREATE TABLE department(
        department_id SERIAL NOT NULL,
        department_name VARCHAR(200),
        
        CONSTRAINT pk_department_id PRIMARY KEY(department_id)
        
        );
        
CREATE TABLE project(   
        project_id SERIAL NOT NULL,
        project_name VARCHAR(200) NOT NULL,
        start_date DATE NOT NULL,
        
        CONSTRAINT pk_project_id PRIMARY KEY(project_id)
        
        );
        
CREATE TABLE employee( 
        employee_id SERIAL NOT NULL,
        job_title_id INT NOT NULL,
        department_id INT NOT NULL,
        last_name VARCHAR (100) NOT NULL,
        first_name VARCHAR (100) NOT NULL,
        gender VARCHAR(20),
        date_of_birth DATE NOT NULL,
        date_of_hire DATE NOT NULL,
        
        CONSTRAINT pk_employee_id PRIMARY KEY(employee_id),
        CONSTRAINT fk_job_title_id FOREIGN KEY (job_title_id) REFERENCES jobtitle(job_title_id),
        CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES department(department_id),
        
        );

CREATE TABLE project_employee(
        project_id SERIAL NOT NULL,
        employee_id SERIAL NOT NULL, 
        
        CONSTRAINT pk_project_id_employee_id PRIMARY KEY(project_id, employee_id),
        CONSTRAINT fk_project_id FOREIGN KEY (project_id) REFERENCES project(project_id),
        CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

--add attributes


INSERT INTO jobtitle(job_title) VALUES ('Manager');
INSERT INTO jobtitle(job_title) VALUES('ProductOwner');
INSERT INTO jobtitle(job_title) VALUES ('Developer');

INSERT INTO department(department_name) VALUES ('Resources');
INSERT INTO department(department_name) VALUES ('Pathway');
INSERT INTO department(department_name) VALUES ('Classroom');


INSERT INTO project(project_name, start_date) VALUES ('Java', '2021-03-15');
INSERT INTO project(project_name, start_date) VALUES ('Database', '2021-03-15');
INSERT INTO project(project_name, start_date) VALUES ('Design', '2021-03-15');

INSERT INTO employee(job_title_id, department_id, first_name, last_name, gender, date_of_birth, date_of_hire)
VALUES  (1, 1, 'Bobby', 'Flay', 'Male', '1998-03-25', '2021-03-15');

INSERT INTO employee(job_title_id, department_id, first_name, last_name, gender, date_of_birth, date_of_hire)
VALUES  (1, 1, 'Brina', 'Jefferson', 'Female', '1998-03-25', '2021-03-15');

INSERT INTO employee(job_title_id, department_id, first_name, last_name, gender, date_of_birth, date_of_hire)
VALUES  (1, 1, 'Bobby', 'Flay', 'Male', '1998-03-25', '2021-03-15');

INSERT INTO employee(job_title_id, department_id, first_name, last_name, gender, date_of_birth, date_of_hire)
VALUES  (1, 1, 'Kesha', 'Barnes', 'Male', '1978-03-20', '2021-03-15');

INSERT INTO employee(job_title_id, department_id, first_name, last_name, gender, date_of_birth, date_of_hire)
VALUES  (2, 2, 'Lonnie', 'Fears', 'Male', '1987-04-27)', '2021-03-15');

INSERT INTO employee(job_title_id, department_id, first_name, last_name, gender, date_of_birth, date_of_hire)
VALUES  (3, 3, 'Khalee', 'Ward', 'Male', '1998-03-25', '2021-03-15');

INSERT INTO employee(job_title_id, department_id, first_name, last_name, gender, date_of_birth, date_of_hire)
VALUES  (2, 3, 'Jon', 'Smith', 'Male', '1960-12-25', '2021-03-15');

INSERT INTO employee(job_title_id, department_id, first_name, last_name, gender, date_of_birth, date_of_hire)
VALUES  (3, 1, 'Teyana', 'Taylor', 'Female', '1978-03-23', '2021-03-15');

INSERT INTO project_employee (project_id, employee_id) VALUES(1,2);
INSERT INTO project_employee (project_id, employee_id) VALUES(2,2);
INSERT INTO project_employee (project_id, employee_id) VALUES(3,3);
INSERT INTO project_employee (project_id, employee_id) VALUES(2,3);

SELECT * FROM employee;
SELECT * FROM project;
SELECT * FROM department;
SELECT * FROM jobtitle;
SELECT * FROM project_employee;