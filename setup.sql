DROP DATABASE IF EXISTS ChineseRestaurant;
CREATE DATABASE ChineseRestaurant;
USE ChineseRestaurant;

CREATE TABLE IF NOT EXISTS `Person` (
    `person_id`     BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `first_name`    VARCHAR(255) NOT NULL,
    `last_name`     VARCHAR(255) NOT NULL,
    `phone_number`  VARCHAR(255) NOT NULL,
    PRIMARY KEY (`person_id`)
);

CREATE TABLE IF NOT EXISTS `Employee` (
    `employee_id` BIGINT UNSIGNED NOT NULL,
    `pay_rate`    DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (`employee_id`),
    CONSTRAINT `fk_employee_person`
        FOREIGN KEY (`employee_id`) REFERENCES `Person`(`person_id`)
);

CREATE TABLE IF NOT EXISTS `Customer` (
    `customer_id`     BIGINT UNSIGNED NOT NULL,
    `loyalty_number`  INT NOT NULL,
    `loyalty_credit`  DECIMAL(8,2) NOT NULL,
    `birth_date`      DATE NULL,
    PRIMARY KEY (`customer_id`),
    UNIQUE KEY `uq_customer_loyalty_number` (`loyalty_number`),
    CONSTRAINT `fk_customer_person`
        FOREIGN KEY (`customer_id`) REFERENCES `Person`(`person_id`)
);

CREATE TABLE IF NOT EXISTS `Shift` (
    `shift_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `start`    DATETIME NOT NULL,
    `end`      DATETIME NOT NULL,
    PRIMARY KEY (`shift_id`),
    CONSTRAINT `ck_shift_interval` CHECK (`start` < `end`)
);

CREATE TABLE IF NOT EXISTS `EmployeeShift` (
    `employee_id` BIGINT UNSIGNED NOT NULL,
    `shift_id`    BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (`employee_id`, `shift_id`),
    CONSTRAINT `fk_es_employee`
        FOREIGN KEY (`employee_id`) REFERENCES `Employee`(`employee_id`),
    CONSTRAINT `fk_es_shift`
        FOREIGN KEY (`shift_id`) REFERENCES `Shift`(`shift_id`)
);

CREATE TABLE IF NOT EXISTS `Order` (
    `order_id`    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` BIGINT UNSIGNED NOT NULL,
    `time`        DATETIME NOT NULL,
    PRIMARY KEY (`order_id`),
    CONSTRAINT `fk_order_customer`
        FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`customer_id`)
);

CREATE TABLE IF NOT EXISTS `Dish` (
    `dish_id`     BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `price`       DECIMAL(8,2) NOT NULL,
    `calories`    INT NULL,
    PRIMARY KEY (`dish_id`)
);

CREATE TABLE IF NOT EXISTS `OrderDish` (
    `order_id`  BIGINT UNSIGNED NOT NULL,
    `dish_id`   BIGINT UNSIGNED NOT NULL,
    `quantity`  INT            NOT NULL,
    PRIMARY KEY (`order_id`, `dish_id`),
    CONSTRAINT `fk_orderdish_order`
        FOREIGN KEY (`order_id`) REFERENCES `Order`(`order_id`),
    CONSTRAINT `fk_orderdish_dish`
        FOREIGN KEY (`dish_id`)  REFERENCES `Dish`(`dish_id`),
    CONSTRAINT `ck_orderdish_quantity` CHECK (`quantity` > 0)
);
