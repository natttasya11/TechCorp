create database TechCorp;
create table products (
	product_id int,
	product_name varchar(50),
    category varchar (50),
    price int,
    stock_quantity int,
    discount int
    );
create table customers (
	customer_id int,
    first_name varchar(50),
    last_name varchar (50),
    email varchar (50),
    phone int,
    address varchar (50)
    );
create table orders (
	customer_id int (50),
	order_date date,
	total_amount int
    );

create table OrderDetails (
	order_id int(50),
    product_id int (50),
	quantity int (50),
    unit_price int
    );
create table employees (
	employee_id int,
	first_name varchar(50),
    last_name varchar (50),
    email varchar (50),
    phone int,
    hire_date date,
    department varchar (50)
    );
CREATE TABLE SupportTickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    issue VARCHAR(50),
    status VARCHAR(50),
    created_at DATETIME,
    resolved_at DATETIME NULL
	);


alter table product rename to products;
alter table customer rename to customers;
ALTER TABLE customers MODIFY address varchar(50);

INSERT INTO Products (product_id,product_name, category, price, stock_quantity, discount)
VALUES
(1,'Laptop Pro 15', 'Laptop', 1500.00, 100, 0),
(2,'Smartphone X', 'Smartphone', 800.00, 200, 0),
(3,'Wireless Mouse', 'Accessories', 25.00, 500, 0),
(4,'USB-C Charger', 'Accessories', 20.00, 300, 0),
(5,'Gaming Laptop', 'Laptop', 2000.00, 50, 10),
(6,'Budget Smartphone', 'Smartphone', 300.00, 150, 5),
(7,'Noise Cancelling Headphones', 'Accessories', 150.00, 120, 15),
(8,'Wireless Earphones', 'Accessories', 100.00, 100, 10);

INSERT INTO Customers (customer_id,first_name, last_name, email, phone, address)
VALUES
(1,'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm Street'),
(2,'Jane', 'Smith', 'jane.smith@example.com', '1234567891', '456 Oak Street'),
(3,'Emily', 'Johnson', 'emily.johnson@example.com', '1234567892', '789 Pine Street'),
(4,'Michael', 'Brown', 'michael.brown@example.com', '1234567893', '101 Maple Street'),
(5,'Sarah', 'Davis', 'sarah.davis@example.com', '1234567894', '202 Birch Street');

INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES
(1, '2023-07-01', 1525.00),
(2, '2023-07-02', 820.00),
(3, '2023-07-03', 25.00),
(1, '2023-07-04', 2010.00),
(4, '2023-07-05', 300.00),
(2, '2023-07-06', 315.00),
(5, '2023-07-07', 165.00);

INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 1500.00),
(1, 3, 1, 25.00),
(2, 2, 1, 800.00),
(2, 4, 1, 20.00),
(3, 3, 1, 25.00),
(4, 5, 1, 2000.00),
(4, 6, 1, 10.00),
(5, 6, 1, 300.00),
(6, 6, 1, 300.00),
(7, 7, 1, 150.00),
(7, 4, 1, 15.00);

INSERT INTO Employees (employee_id,first_name, last_name, email, phone, hire_date, department)
VALUES
(1,'Alice', 'Williams', 'alice.williams@example.com', '1234567895', '2022-01-15', 'Support'),
(2,'Bob', 'Miller', 'bob.miller@example.com', '1234567896', '2022-02-20', 'Sales'),
(3,'Charlie', 'Wilson', 'charlie.wilson@example.com', '1234567897', '2022-03-25', 'Development'),
(4,'David', 'Moore', 'david.moore@example.com', '1234567898', '2022-04-30', 'Support'),
(5,'Eve', 'Taylor', 'eve.taylor@example.com', '1234567899', '2022-05-10', 'Sales');

INSERT INTO SupportTickets (customer_id, employee_id, issue, status, created_at, resolved_at)
VALUES
(1, 1, 'Cannot connect to Wi-Fi', 'resolved', '2023-07-01 10:00:00', '2023-07-01 11:00:00'),
(2, 1, 'Screen flickering', 'resolved', '2023-07-02 12:00:00', '2023-07-02 13:00:00'),
(3, 1, 'Battery drains quickly', 'open', '2023-07-03 14:00:00', NULL),
(4, 2, 'Late delivery', 'resolved', '2023-07-04 15:00:00', '2023-07-04 16:00:00'),
(5, 2, 'Damaged product', 'open', '2023-07-05 17:00:00', NULL),
(1, 3, 'Software issue', 'resolved', '2023-07-06 18:00:00', '2023-07-06 19:00:00'),
(2, 3, 'Bluetooth connectivity issue', 'resolved', '2023-07-07 20:00:00', '2023-07-07 21:00:00'),
(5, 4, 'Account issue', 'open', '2023-07-08 22:00:00', NULL),
(3, 4, 'Payment issue', 'resolved', '2023-07-09 23:00:00', '2023-07-09 23:30:00'),
(4, 5, 'Physical damage', 'open', '2023-07-10 08:00:00', NULL),
(4, 1, 'Laptop blue screen', 'resolved', '2024-01-05 10:00:00', '2024-02-05 12:00:00'),
(5, 1, 'Laptop lagging', 'resolved', '2024-01-06 10:00:00', '2024-01-25 12:00:00'),
(3, 1, 'Some part of laptop broken', 'resolved', '2024-02-05 10:00:00', '2024-03-05 12:00:00');

select * from SupportTickets;

-- 1. Identifikasi 3 pelanggan teratas berdasarkan total nominal pesanan!
select
	o.customer_id,
    c.first_name,
    c.last_name,
	sum(o.total_amount) as total_spend
from orders o
join
	customers c on c.customer_id = o.customer_id
group by o.customer_id, c.first_name,c.last_name
order by total_spend desc
limit 3;


-- 2  Temukan rata-rata nominal pesanan untuk setiap pelanggan!
select 
	c.first_name,
	c.last_name,
    o.customer_id,
	avg(o.total_amount),2 as avg_amount
from customers c
join 
	orders o on c.customer_id = o.customer_id
group by customer_id
order by customer_id asc
;

-- 3. Temukan semua karyawan yang telah menyelesaikan lebih dari 4 tiket support!
select 
	S.employee_id,
	e.first_name,
    count(*) as total_resolved
from SupportTickets s
join
	employees e on e.employee_id = s.employee_id
where
	status = 'resolved'
group by employee_id
having count(*)  > 4
;

-- 4. Temukan semua produk yang belum pernah dipesan!
select 
	od.order_id,
	p.product_name
from products p
left join
	orderdetails od on od.product_id = p.product_id
where od.product_id is NULL
;
	
-- 5. Hitung total pendapatan yang dihasilkan dari penjualan produk!
select 
	p.product_name,
	od.product_id,
	sum(od.unit_price) as total_revenue
from products p
join
	orderdetails od on od.product_id = p.product_id
group by
	product_id
;

select 
sum(quantity*unit_price) as total_revenue
from orderdetails;

-- 6. Temukan harga rata-rata produk untuk setiap kategori dan temukan kategori dengan harga rata-rata lebih dari $500!

with cte_avg_price as (
select
	category,
    round(avg(price),2) as avg_price
from products
where avg_price >$500
group by category )
select*from cte_avg_price where avg_price > 500
;
select
	category,
    round(avg(price),2) as avg_price
from products
group by category
having avg_price >500;


-- 7. Temukan pelanggan yang telah membuat setidaknya satu pesanan dengan total jumlah lebih dari $1000!
select 
o.customer_id,
c.first_name,
c.last_name,
sum(o.total_amount) as total_ordering
from customers c
join
	orders o on c.customer_id = o.customer_id
group by customer_id
having total_ordering >1000;