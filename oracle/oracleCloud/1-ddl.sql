drop table if exists departments;
drop table if exists employees;
drop table if exists sales;

CREATE TABLE departments ( 
    department_id NUMBER PRIMARY KEY, 
    department_name VARCHAR2(50) 
);


INSERT INTO departments (department_id, department_name) 
VALUES (1, 'HR');
INSERT INTO departments (department_id, department_name) 
VALUES (2, 'IT');
INSERT INTO departments (department_id, department_name) 
VALUES (3, 'Finance');

CREATE TABLE employees ( 
    emp_id NUMBER PRIMARY KEY, 
    emp_name VARCHAR2(100) NOT NULL, 
    department_id NUMBER, 
    salary NUMBER, 
    CONSTRAINT fk_department 
        FOREIGN KEY (department_id) 
        REFERENCES departments (department_id) 
);

INSERT INTO employees (emp_id, emp_name, department_id, salary) 
VALUES (1, 'John Doe', 1, 50000);
INSERT INTO employees (emp_id, emp_name, department_id, salary) 
VALUES (2, 'Jane Smith', 2, 60000);
INSERT INTO employees (emp_id, emp_name, department_id, salary) 
VALUES (3, 'Mike Johnson', 3, 70000);
INSERT INTO employees (emp_id, emp_name, department_id, salary) 
VALUES (4, 'Lisa Lee', 1, 55000);

CREATE TABLE sales ( 
    sale_id NUMBER PRIMARY KEY, 
    product_name VARCHAR2(100), 
    sales_amount NUMBER, 
    sales_date DATE 
);

INSERT INTO sales (sale_id, product_name, sales_amount, sales_date) 
VALUES (1, 'Product A', 1000, TO_DATE('2023-08-01', 'YYYY-MM-DD'));

INSERT INTO sales (sale_id, product_name, sales_amount, sales_date) 
VALUES (2, 'Product B', 1500, TO_DATE('2023-08-01', 'YYYY-MM-DD'));

INSERT INTO sales (sale_id, product_name, sales_amount, sales_date) 
VALUES (3, 'Product A', 800, TO_DATE('2023-08-02', 'YYYY-MM-DD'));

INSERT INTO sales (sale_id, product_name, sales_amount, sales_date) 
VALUES (4, 'Product C', 2000, TO_DATE('2023-08-02', 'YYYY-MM-DD'));
