CREATE TABLE users (
	users_id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(255),
	email VARCHAR(255),
	pass_word VARCHAR(255)
)

INSERT INTO users (users_id, full_name, email, pass_word) VALUES
(1, "Nguyen Van A", "A@gmail.com", "1234"),
(2, "Nguyen Van B", "B@gmail.com", "1234"),
(3, "Nguyen Van C", "C@gmail.com", "1234"),
(4, "Nguyen Van D", "D@gmail.com", "1234"),
(5, "Nguyen Van E", "E@gmail.com", "1234");

CREATE TABLE food (
    food_id INT AUTO_INCREMENT PRIMARY KEY,
    food_name VARCHAR(255),
    image VARCHAR(255),
    price FLOAT,
    description VARCHAR(255)
  
);



CREATE TABLE restaurant (
    res_id INT AUTO_INCREMENT PRIMARY KEY,
    res_name VARCHAR(255),
    image VARCHAR(255),
    description VARCHAR(255)
);



CREATE TABLE sub_food (
    sub_id INT AUTO_INCREMENT PRIMARY KEY,
    sub_name VARCHAR(255),
    sub_price FLOAT,
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE orders (
    orders_id INT AUTO_INCREMENT PRIMARY KEY,
    users_id INT,
    food_id INT,
    amount INT,
    code VARCHAR(255),
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (users_id) REFERENCES users (users_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE rate_res (
    users_id INT,
    res_id INT AUTO_INCREMENT PRIMARY KEY,
    amount INT,
    date_rate DATETIME,
    FOREIGN KEY (users_id) REFERENCES users (users_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

CREATE TABLE like_res (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    users_id INT,
    res_id INT,
    date_like DATETIME,
    FOREIGN KEY (users_id) REFERENCES users(users_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);




INSERT INTO food (food_id,food_name, image, price, description)
VALUES
    (1,'Pizza', 'pizza.jpg', 10.99, 'Delicious pepperoni pizza'),
    (2,'Burger', 'burger.jpg', 8.99, 'Juicy cheeseburger'),
    (3,'Sushi', 'sushi.jpg', 15.99, 'Fresh sashimi and rolls'),
    (4,'Pasta', 'pasta.jpg', 9.99, 'Creamy Alfredo pasta')


INSERT INTO restaurant (res_id,res_name, image, description)
VALUES
    (1,'Pizza Hut', 'pizzahut.jpg', 'A popular pizza chain'),
    (2,'Burger King', 'burgerking.jpg', 'A fast-food chain known for burgers'),
    (3,'Sushi House', 'sushihouse.jpg', 'A Japanese restaurant specializing in sushi'),
    (4,'Pasta Palace', 'pastapalace.jpg', 'An Italian restaurant serving various pasta dishes');


INSERT INTO rate_res (users_id, res_id, amount, date_rate)
VALUES
    (1, 1, 4, '2023-11-15 12:00:00'),
    (2, 2, 5, '2023-12-20 15:30:00'),
    (3, 3, 3, '2023-12-25 18:45:00'),
    (1, 4, 2, '2024-01-01 10:15:00');

INSERT INTO like_res (users_id, res_id, date_like)
VALUES
    (1, 1, '2023-11-10 10:00:00'),
    (2, 3, '2023-12-22 17:30:00'),
    (3, 2, '2024-01-05 12:45:00'),
    (1, 4, '2024-01-10 15:15:00');


INSERT INTO orders (orders_id,users_id, food_id, amount, code, arr_sub_id)
VALUES
(1,1, 1, 2, 'DISCOUNT10', 'S1'),
(2,2, 2, 1, 'SUMMER20', 'S2'),
(3,3, 3, 3, 'WINTER15', 'S3'),
(4,4, 4, 5, 'DISCOUNT25', 'S4'),
(5,5,1, 1, 'NEWYEAR5', 'S5');





-- -- Tìm 5 người đã like nhà hàng nhiều nhất 
SELECT COUNT(orders.users_id) AS "Số lần mua", users.full_name, users.email
FROM orders
INNER JOIN users on orders.users_id = users.users_id
GROUP BY orders.users_id
ORDER BY `Số lần mua` DESC
LIMIT 5


-- Tìm người đã đặt hàng nhiều nhất.
SELECT res_name, COUNT(like_res.like_id) AS like_count
FROM restaurant 
JOIN like_res  ON restaurant.res_id = like_res.res_id
GROUP BY res_name
ORDER BY like_count DESC
LIMIT 2;

-- nguoi dat hang nhieu nhat	
SELECT full_name, COUNT(orders.orders_id) AS order_count
FROM users 
JOIN orders  ON users.users_id = orders.users_id
GROUP BY full_name
ORDER BY order_count DESC
LIMIT 1;




SELECT u.full_name
FROM users u
LEFT JOIN orders o ON u.users_id = o.users_id
LEFT JOIN like_res l ON u.users_id = l.users_id
LEFT JOIN rate_res r ON u.users_id = r.users_id
WHERE o.users_id IS NULL
 AND l.users_id IS NULL
 AND r.users_id IS NULL;





