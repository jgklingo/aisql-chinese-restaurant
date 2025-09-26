USE ChineseRestaurant;

-- ------------------------------------------------------------
-- Reset data (in FK-safe order)
-- ------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE OrderDish;
TRUNCATE TABLE EmployeeShift;
TRUNCATE TABLE `Order`;
TRUNCATE TABLE `Shift`;
TRUNCATE TABLE Employee;
TRUNCATE TABLE Customer;
TRUNCATE TABLE Dish;
TRUNCATE TABLE Person;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------
-- Persons
--   IDs are explicit so subtypes can reference them directly.
--   1–6 employees, 7–20 customers
-- ------------------------------------------------------------
INSERT INTO Person (person_id, first_name, last_name, phone_number) VALUES
(1,  'Li',      'Wei',     '555-1001'),
(2,  'Chen',    'Ming',    '555-1002'),
(3,  'Wang',    'Fang',    '555-1003'),
(4,  'Zhao',    'Hui',     '555-1004'),
(5,  'Liu',     'Yan',     '555-1005'),
(6,  'Zhang',   'Lei',     '555-1006'),
(7,  'Sun',     'Jie',     '555-2001'),
(8,  'Guo',     'Qiang',   '555-2002'),
(9,  'Huang',   'Mei',     '555-2003'),
(10, 'Xu',      'Peng',    '555-2004'),
(11, 'Zhou',    'Ling',    '555-2005'),
(12, 'Gao',     'Rui',     '555-2006'),
(13, 'Deng',    'Xia',     '555-2007'),
(14, 'He',      'Tao',     '555-2008'),
(15, 'Cai',     'Ning',    '555-2009'),
(16, 'Yao',     'Kun',     '555-2010'),
(17, 'Qin',     'Lan',     '555-2011'),
(18, 'Pan',     'Bo',      '555-2012'),
(19, 'Nie',     'Min',     '555-2013'),
(20, 'Luo',     'Zhen',    '555-2014');

-- ------------------------------------------------------------
-- Employees (subtype of Person)
-- ------------------------------------------------------------
INSERT INTO Employee (employee_id, pay_rate) VALUES
(1,  18.50),  -- server
(2,  24.00),  -- wok chef
(3,  19.75),  -- server
(4,  26.50),  -- head chef
(5,  17.25),  -- host
(6,  21.00);  -- line cook

-- ------------------------------------------------------------
-- Customers (subtype of Person)
-- ------------------------------------------------------------
INSERT INTO Customer (customer_id, loyalty_number, loyalty_credit, birth_date) VALUES
(7,  10001,  15.00, '1990-04-12'),
(8,  10002,   8.50, '1985-08-23'),
(9,  10003,   0.00, '2000-02-14'),
(10, 10004,  20.75, '1995-06-30'),
(11, 10005,   5.00, '1978-12-05'),
(12, 10006,  11.25, '1988-11-19'),
(13, 10007,   3.50, '1993-03-08'),
(14, 10008,   0.00, '1999-09-01'),
(15, 10009,   6.00, '1982-07-17'),
(16, 10010,   9.00, '1991-01-05'),
(17, 10011,   2.25, '2001-10-28'),
(18, 10012,  13.10, '1994-05-11'),
(19, 10013,   4.75, '1986-02-02'),
(20, 10014,   7.20, '1997-12-22');

-- ------------------------------------------------------------
-- Menu (authentic Chinese dishes)
-- ------------------------------------------------------------
INSERT INTO Dish (name, description, price, calories) VALUES
('Kung Pao Chicken',        'Spicy stir-fried chicken with peanuts, bell peppers, and dried chilies (Sichuan).', 12.50, 650),
('Mapo Tofu',                'Silken tofu in numbing-spicy doubanjiang sauce with minced pork (Sichuan).',         10.50, 520),
('Sweet and Sour Pork',      'Cantonese-style crispy pork with balanced sweet-tangy sauce and peppers.',           11.75, 700),
('Beef Chow Fun',            'Wok-charred wide rice noodles with beef and bean sprouts (Cantonese).',              13.25, 720),
('Hot and Sour Soup',        'Black fungus, bamboo shoots, tofu, and white pepper in tangy broth.',                 6.50, 200),
('Spring Rolls',             'Crisp vegetarian rolls with cabbage, carrot, and glass noodles.',                      5.25, 180),
('Peking Duck',              'Crispy roasted duck served with pancakes, scallions, and hoisin.',                   28.00, 1200),
('Shrimp Fried Rice',        'Fragrant jasmine rice with shrimp, egg, and scallions.',                               9.50, 600),
('Sichuan Dry-Fried Beans',  'Haricot verts blistered with garlic, chilies, and preserved mustard greens.',          8.75, 310),
('Steamed Pork Dumplings',   'Juicy dumplings with pork and napa cabbage; soy-vinegar dip.',                         7.95, 420),
('Dan Dan Noodles',          'Wheat noodles with sesame, chili oil, and minced pork topping (Sichuan).',           10.95, 640),
('Twice-Cooked Pork',        'Pork belly simmered then stir-fried with leeks and doubanjiang.',                    12.95, 780),
('Lion’s Head Meatballs',    'Braised pork meatballs with napa cabbage (Jiangsu).',                                14.50, 850),
('Xiao Long Bao',            'Soup-filled dumplings served steaming hot (Shanghai).',                               9.25, 430),
('Ma Po Eggplant',           'Silky eggplant in spicy bean paste with garlic and scallions.',                        9.95, 360);

-- ------------------------------------------------------------
-- Shifts (two per day for 7 days)
-- IDs will be 1..14 in insertion order after TRUNCATE.
-- ------------------------------------------------------------
INSERT INTO Shift (`start`, `end`) VALUES
('2025-09-25 10:00:00','2025-09-25 16:00:00'),
('2025-09-25 16:00:00','2025-09-25 22:00:00'),
('2025-09-26 10:00:00','2025-09-26 16:00:00'),
('2025-09-26 16:00:00','2025-09-26 22:00:00'),
('2025-09-27 10:00:00','2025-09-27 16:00:00'),
('2025-09-27 16:00:00','2025-09-27 22:00:00'),
('2025-09-28 10:00:00','2025-09-28 16:00:00'),
('2025-09-28 16:00:00','2025-09-28 22:00:00'),
('2025-09-29 10:00:00','2025-09-29 16:00:00'),
('2025-09-29 16:00:00','2025-09-29 22:00:00'),
('2025-09-30 10:00:00','2025-09-30 16:00:00'),
('2025-09-30 16:00:00','2025-09-30 22:00:00'),
('2025-10-01 10:00:00','2025-10-01 16:00:00'),
('2025-10-01 16:00:00','2025-10-01 22:00:00');

-- Assign employees to each shift (servers on day, chefs on night; rotated)
INSERT INTO EmployeeShift (employee_id, shift_id) VALUES
-- 2025-09-25
(1,1),(2,1),(5,1),   -- day: server Li, chef Chen, host Liu
(3,2),(4,2),(6,2),   -- night: server Wang, head chef Zhao, cook Zhang
-- 2025-09-26
(1,3),(6,3),(5,3),
(3,4),(2,4),(4,4),
-- 2025-09-27
(1,5),(2,5),(5,5),
(3,6),(4,6),(6,6),
-- 2025-09-28
(1,7),(6,7),(5,7),
(3,8),(2,8),(4,8),
-- 2025-09-29
(1,9),(2,9),(5,9),
(3,10),(4,10),(6,10),
-- 2025-09-30
(1,11),(6,11),(5,11),
(3,12),(2,12),(4,12),
-- 2025-10-01
(1,13),(2,13),(5,13),
(3,14),(4,14),(6,14);

-- ------------------------------------------------------------
-- Orders across 7 days (order_id will be 1..N by insertion order)
-- ------------------------------------------------------------
INSERT INTO `Order` (customer_id, `time`) VALUES
-- 2025-09-25
(7,  '2025-09-25 12:15:00'),
(8,  '2025-09-25 18:45:00'),
(9,  '2025-09-25 19:30:00'),
-- 2025-09-26
(10, '2025-09-26 13:05:00'),
(11, '2025-09-26 20:10:00'),
(12, '2025-09-26 21:00:00'),
-- 2025-09-27
(13, '2025-09-27 12:40:00'),
(14, '2025-09-27 13:10:00'),
(15, '2025-09-27 19:05:00'),
-- 2025-09-28
(16, '2025-09-28 12:10:00'),
(17, '2025-09-28 18:25:00'),
(18, '2025-09-28 20:50:00'),
-- 2025-09-29
(19, '2025-09-29 12:05:00'),
(20, '2025-09-29 13:20:00'),
(7,  '2025-09-29 19:45:00'),
-- 2025-09-30
(8,  '2025-09-30 12:30:00'),
(9,  '2025-09-30 18:15:00'),
(10, '2025-09-30 20:40:00'),
-- 2025-10-01
(11, '2025-10-01 12:25:00'),
(12, '2025-10-01 13:35:00'),
(13, '2025-10-01 18:05:00'),
(14, '2025-10-01 19:10:00');

-- ------------------------------------------------------------
-- Order line items (bridge): (order_id, dish_id, quantity)
--   Dish IDs correspond to insertion order in Dish table (1..15).
-- ------------------------------------------------------------
INSERT INTO OrderDish (order_id, dish_id, quantity) VALUES
-- Orders on 2025-09-25 (order_id 1..3)
(1, 1, 1),   -- Kung Pao Chicken
(1, 5, 2),   -- Hot and Sour Soup
(1, 6, 1),   -- Spring Rolls
(2, 3, 1),   -- Sweet and Sour Pork
(2, 8, 1),   -- Shrimp Fried Rice
(3, 2, 1),   -- Mapo Tofu
(3, 9, 1),   -- Sichuan Dry-Fried Beans
(3, 14,1),   -- Xiao Long Bao
-- Orders on 2025-09-26 (order_id 4..6)
(4, 4, 1),   -- Beef Chow Fun
(4, 10,2),   -- Steamed Pork Dumplings
(5, 7, 1),   -- Peking Duck
(5, 6, 1),   -- Spring Rolls
(6, 1, 1),
(6, 11,1),   -- Dan Dan Noodles
-- Orders on 2025-09-27 (order_id 7..9)
(7, 2, 1),
(7, 9, 1),
(8, 11,1),
(8, 10,1),
(9, 12,1),   -- Twice-Cooked Pork
(9, 8, 1),
-- Orders on 2025-09-28 (order_id 10..12)
(10, 4, 1),
(10, 5, 2),
(11, 13,1),  -- Lion’s Head Meatballs
(11, 14,1),
(12, 1, 1),
(12, 15,1),  -- Ma Po Eggplant
-- Orders on 2025-09-29 (order_id 13..15)
(13, 8, 1),
(13, 6, 1),
(14, 3, 1),
(14, 10,1),
(15, 11,2),
(15, 2, 1),
-- Orders on 2025-09-30 (order_id 16..18)
(16, 4, 1),
(16, 14,1),
(17, 12,1),
(17, 9, 1),
(18, 7, 1),
(18, 5, 2),
-- Orders on 2025-10-01 (order_id 19..22)
(19, 13,1),
(19, 10,1),
(20, 15,1),
(20, 8, 1),
(21, 1, 1),
(21, 11,1),
(22, 2, 1),
(22, 9, 1);

-- Optional: modest loyalty credit accrual (example updates)
-- UPDATE Customer SET loyalty_credit = loyalty_credit + 2.00 WHERE customer_id IN (7,8,9,10,11,12,13,14,15,16,17,18,19,20);
