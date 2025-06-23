
-- employee management system sql script
-- full step-by-step workflow: create, insert, update, delete, select

-- step 1: create all required tables

create table login (
    email varchar(100) primary key,
    password varchar(100) not null
);

create table registration (
    id int auto_increment primary key,
    name varchar(100),
    email varchar(100) unique,
    password varchar(100)
);

create table department (
    id int auto_increment primary key,
    department_name varchar(100)
);

create table manager (
    id int auto_increment primary key,
    manager_name varchar(100),
    department_id int,
    foreign key (department_id) references department(id)
);

create table employee (
    id int auto_increment primary key,
    name varchar(100),
    email varchar(100) unique,
    salary decimal(10,2),
    department_id int,
    foreign key (department_id) references department(id)
);

create table salary_log (
    log_id int auto_increment primary key,
    employee_id int,
    old_salary decimal(10,2),
    new_salary decimal(10,2),
    changed_at timestamp default current_timestamp,
    foreign key (employee_id) references employee(id)
);

-- step 2: create procedures and triggers

delimiter //
create procedure add_employee (
    in emp_name varchar(100),
    in emp_email varchar(100),
    in emp_salary decimal(10,2),
    in dept_id int
)
begin
    insert into employee (name, email, salary, department_id)
    values (emp_name, emp_email, emp_salary, dept_id);
end //
delimiter ;

delimiter //
create procedure update_employee_salary (
    in emp_id int,
    in new_salary decimal(10,2)
)
begin
    update employee
    set salary = new_salary
    where id = emp_id;
end //
delimiter ;

delimiter //
create procedure delete_employee (
    in emp_id int
)
begin
    delete from employee where id = emp_id;
end //
delimiter ;

delimiter //
create trigger after_salary_update
after update on employee
for each row
begin
    if old.salary <> new.salary then
        insert into salary_log (employee_id, old_salary, new_salary)
        values (old.id, old.salary, new_salary);
    end if;
end //
delimiter ;

delimiter //
create trigger after_employee_delete
after delete on employee
for each row
begin
    insert into salary_log (employee_id, old_salary, new_salary, changed_at)
    values (old.id, old.salary, null, current_timestamp);
end //
delimiter ;

-- step 3: insert initial data

insert into department (department_name) values ('hr'), ('it'), ('finance');

insert into manager (manager_name, department_id) values ('alice', 1), ('bob', 2);

call add_employee('ravi kumar', 'ravi@gmail.com', 40000, 1);
call add_employee('sneha singh', 'sneha@gmail.com', 55000, 2);
call add_employee('amit verma', 'amit@gmail.com', 60000, 2);

insert into registration (name, email, password)
values ('ravi kumar', 'ravi@gmail.com', 'ravi123');

insert into login (email, password)
values ('ravi@gmail.com', 'ravi123');

-- step 4: update data

call update_employee_salary(1, 45000);

-- step 5: delete data

call delete_employee(2);

-- step 6: show data

-- show all employees
select * from employee;

-- show all salary log
select * from salary_log;

-- show all departments
select * from department;

-- joined employee report with department and manager
select 
    e.id as employee_id,
    e.name as employee_name,
    e.email,
    e.salary,
    d.department_name,
    m.manager_name
from employee e
join department d on e.department_id = d.id
left join manager m on m.department_id = d.id;
