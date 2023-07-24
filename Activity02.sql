CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    manufactured_date date
)

PARTITION BY RANGE(id)
(partition p0 values less than (1100),
	partition p1 values less than (1200),
	partition p2 values less than (1300),
	partition p3 values less than (1400),
	partition p4 values less than (1500),
    partition p5 values less than (1600),
    partition p6 values less than (1700),
    partition p7 values less than (1800),
    partition p8 values less than (1900),
    partition p9 values less than MAXVALUE);
    
    
CALL insert_products(1000,2000);
select * from products;

CALL Update_Data(1001,1003);
