# Employee_Management
MYSQL PROJECT

# Create a README.md file with explanations for the SQL script structure and usage

readme_content = """
# Employee Management System - SQL Script

This SQL script sets up a complete **Employee Management System** database with essential tables, stored procedures, triggers, and step-by-step operations for creating, inserting, updating, deleting, and selecting data.

## 📁 Database Structure

### 1. Tables

- `login`: Stores user login credentials.
- `registration`: Handles user registration details.
- `department`: Stores department names.
- `manager`: Links managers to departments.
- `employee`: Main employee information with salary and department references.
- `salary_log`: Logs salary changes for employees (audit trail).

### 2. Stored Procedures

- `add_employee`: Adds a new employee.
- `update_employee_salary`: Updates an employee's salary.
- `delete_employee`: Deletes an employee from the system.

### 3. Triggers

- `after_salary_update`: Automatically logs salary changes.
- `after_employee_delete`: Logs employee deletion with their last salary.

## ⚙️ Step-by-Step Workflow

### ✅ Step 1: Create All Tables
Initial setup for all required tables (`login`, `employee`, `department`, etc.).

### ✨ Step 2: Create Procedures and Triggers
Add necessary procedures for inserting, updating, deleting employee records, and triggers for logging changes.

### 📝 Step 3: Insert Initial Data
Sample data insertion for departments, managers, and employees using the stored procedure `add_employee`.

### 🔁 Step 4: Update Data
Example of updating salary using `update_employee_salary`.

### ❌ Step 5: Delete Data
Deleting an employee using the `delete_employee` procedure.

### 📊 Step 6: Show Data
Queries for retrieving:
- All employees
- Salary log
- Department list
- Joined report with employee, department, and manager details

## ▶️ Example Queries

```sql
-- Show all employees
select * from employee;

-- View salary change history
select * from salary_log;

-- Department report
select * from department;

-- Full employee report with department and manager
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
