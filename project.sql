use project;
show tables;
CREATE TABLE CUSTOMER (
    customer_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    phone_no VARCHAR(15),
    PRIMARY KEY (customer_id)
);

CREATE TABLE ROOMS (
    room_id INT NOT NULL AUTO_INCREMENT,
    room_type VARCHAR(50) NOT NULL,
    room_description TEXT,
    room_image VARCHAR(1000),
    room_price DECIMAL(10,2) NOT NULL,
    availability_status TINYINT(1) DEFAULT 1,
    PRIMARY KEY (room_id)
);

CREATE TABLE BOOKING (
    booking_id INT NOT NULL AUTO_INCREMENT,
    cust_id INT,
    room_id INT,
    checkin_date DATE,
    checkout_date DATE,
    booking_status INT,
    booking_mode TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (room_id) REFERENCES ROOM(room_id)
);

abc
CREATE TABLE OFFLINECUSTOMER (
    customer_id INT NOT NULL AUTO_INCREMENT,
    booking_id INT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_no VARCHAR(15),
    PRIMARY KEY (customer_id),
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
) AUTO_INCREMENT = 1000;


CREATE TABLE FEEDBACK (
    feedback_id INT NOT NULL AUTO_INCREMENT,
    cust_id INT,
    booking_id INT,
    given_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    feedback_text TEXT,
    rating INT,
    PRIMARY KEY (feedback_id),
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(customer_id), 
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
);

CREATE TABLE FOOD_MENU (
    item_id INT NOT NULL AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    description_of_item TEXT,
    item_price DECIMAL(10,2) NOT NULL,
    item_image VARCHAR(1000),
    item_type INT NOT NULL,
    availability_status TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (item_id)
);



CREATE TABLE FOODORDER (
    order_id INT NOT NULL AUTO_INCREMENT,
    cust_id INT,
    booking_id INT,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_total_price DECIMAL(10,2) NOT NULL,
    orderstatus TINYINT(1) DEFAULT 0,
    room_id INT,
    PRIMARY KEY (order_id),
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id),
    FOREIGN KEY (room_id) REFERENCES ROOMS(room_id)
);

CREATE TABLE ORDERITEMS (
    orderitem_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    totalitems_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES FOODORDER(order_id)
);

CREATE TABLE BILLING (
    bill_id INT NOT NULL AUTO_INCREMENT,
    cust_id INT,
    booking_id INT,
    total_bill DECIMAL(10,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (bill_id),
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(customer_id),   
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id) 
);


