-- Таблица ролей пользователей
CREATE TABLE user_role (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

-- Таблица пользователей
CREATE TABLE user (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role_id INT NOT NULL,
    registration_date DATE NOT NULL,
    FOREIGN KEY (role_id) REFERENCES user_role(role_id)
);

-- Таблица брендов
CREATE TABLE brand (
    brand_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица типов товаров
CREATE TABLE product_type (
    type_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Таблица поставщиков
CREATE TABLE supplier (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(255)
);

-- Таблица товаров
CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    brand_id INT NOT NULL,
    supplier_id INT NOT NULL,
    type_id INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
    FOREIGN KEY (type_id) REFERENCES product_type(type_id)
);

-- Таблица изображений товаров
CREATE TABLE product_image (
    image_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Таблица избранных товаров
CREATE TABLE favorite (
    favorite_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Таблица корзины
CREATE TABLE cart (
    cart_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Таблица заказов
CREATE TABLE order (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- Таблица деталей заказа
CREATE TABLE order_detail (
    detail_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES order(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Вставка данных в таблицу ролей пользователей
INSERT INTO user_role (role_name) VALUES
('Admin'),    -- Администратор
('Customer'), -- Покупатель (авторизованный)
('Guest'),    -- Гость (не авторизованный)
('Manager');  -- Менеджер

-- Вставка данных в таблицу брендов
INSERT INTO brand (name) VALUES
('Brand A'),
('Brand B'),
('Brand C'),
('Brand D'),
('Brand E'),
('Brand F'),
('Brand G'),
('Brand H'),
('Brand I');

-- Вставка данных в таблицу типов товаров
INSERT INTO product_type (name) VALUES
('Electronics'),        -- Электроника
('Clothing'),           -- Одежда
('Home Appliances'),    -- Бытовая техника
('Furniture'),          -- Мебель
('Books'),              -- Книги
('Toys'),               -- Игрушки
('Gardening Tools'),    -- Инструменты для сада
('Sports Equipment'),   -- Спортивное оборудование
('Stationery');         -- Канцелярия

-- Вставка данных в таблицу поставщиков
INSERT INTO supplier (name, contact_info) VALUES
('Supplier X', 'contact@supplierx.com'),
('Supplier Y', 'contact@suppliery.com'),
('Supplier Z', 'contact@supplierz.com'),
('Supplier W', 'contact@supplierw.com'),
('Supplier A', 'contact@suppliera.com'),
('Supplier B', 'contact@supplierb.com'),
('Supplier C', 'contact@supplierc.com'),
('Supplier D', 'contact@supplierd.com'),
('Supplier E', 'contact@suppliere.com');

-- Вставка данных в таблицу пользователей
INSERT INTO user (name, email, role_id, registration_date) VALUES
('Alice', 'alice@example.com', 1, '2024-01-15'),
('Bob', 'bob@example.com', 2, '2024-02-10'),
('Charlie', 'charlie@example.com', 3, '2024-03-15'),
('David', 'david@example.com', 4, '2024-04-10'),
('Eve', 'eve@example.com', 2, '2024-05-01'),
('Frank', 'frank@example.com', 2, '2024-06-12'),
('Grace', 'grace@example.com', 3, '2024-07-23'),
('Henry', 'henry@example.com', 3, '2024-08-14'),
('Stepan', 'ivy@example.com', 4, '2024-09-19');

-- Вставка данных в таблицу товаров
INSERT INTO product (name, description, price, brand_id, supplier_id, type_id) VALUES
('Laptop', 'High performance laptop', 1200, 1, 1, 1),           -- Ноутбук от Brand A и Supplier X
('Smartphone', 'Latest model smartphone', 800, 2, 2, 1),       -- Смартфон от Brand B и Supplier Y
('Washing Machine', 'High-efficiency washing machine', 700, 3, 3, 3), -- Стиральная машина от Brand C и Supplier Z
('Sofa', 'Comfortable 3-seater sofa', 300, 4, 4, 4),           -- Диван от Brand D и Supplier W
('Tablet', 'Lightweight tablet for everyday use', 500, 1, 1, 1),  -- Планшет от Brand A и Supplier X
('TV', '4K Ultra HD TV', 1500, 2, 2, 1),                       -- Телевизор от Brand B и Supplier Y
('Refrigerator', 'Energy-efficient refrigerator', 900, 3, 3, 3), -- Холодильник от Brand C и Supplier Z
('Office Chair', 'Ergonomic office chair', 150, 4, 4, 4),      -- Офисное кресло от Brand D и Supplier W
('Desk', 'Modern computer desk', 250, 5, 5, 4),                -- Компьютерный стол от Brand E и Supplier A
('Novel', 'Bestselling novel', 12.99, 6, 2, 5),                -- Книга от Brand F и Supplier Y
('Toy Car', 'Remote control toy car', 29.99, 7, 1, 6),         -- Игрушечная машинка от Brand G и Supplier X
('Football', 'Professional football', 19.99, 8, 3, 7),         -- Футбол от Brand H и Supplier Z
('Notebook', 'Spiral notebook 100 pages', 2.99, 9, 4, 9),      -- Блокнот от Brand I и Supplier W
('Gardening Kit', 'Complete gardening tool kit', 39.99, 5, 5, 8); -- Набор садовых инструментов от Brand E и Supplier E

-- Вставка данных в таблицу заказов
INSERT INTO order (user_id, order_date, status) VALUES
(1, '2024-09-10', 'Completed'),   -- Заказ для Alice, завершен
(2, '2024-10-01', 'Pending'),     -- Заказ для Bob, в ожидании
(3, '2024-10-15', 'Completed'),   -- Заказ для Charlie, завершен
(4, '2024-10-20', 'Pending'),     -- Заказ для David, в ожидании
(1, '2024-09-15', 'Completed'),   -- Второй заказ для Alice, завершен
(2, '2024-09-20', 'Shipped'),     -- Заказ Bob, отправлен
(3, '2024-09-25', 'Pending'),     -- Заказ Charlie, в ожидании
(4, '2024-09-30', 'Completed'),   -- Заказ David, завершен
(5, '2024-10-05', 'Shipped'),     -- Заказ для Eve, отправлен
(1, '2024-10-10', 'Completed'),   -- Третий заказ для Alice, завершен
(2, '2024-10-15', 'Pending'),     -- Второй заказ Bob, в ожидании
(3, '2024-10-20', 'Shipped'),     -- Второй заказ Charlie, отправлен
(4, '2024-10-25', 'Completed'),   -- Второй заказ David, завершен
(5, '2024-10-30', 'Pending');     -- Второй заказ Eve, в ожидании

-- Вставка данных в таблицу деталей заказа
INSERT INTO order_detail (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1200),  -- Заказ Alice ноутбук
(1, 2, 2, 800),   -- Заказ Alice 2 смартфона
(2, 3, 1, 700),   -- Заказ Bob 1 стиральная машина
(3, 4, 1, 300),   -- Заказ Charlie диван
(5, 5, 1, 1200),  -- Заказ Eve планшет
(6, 6, 2, 800),   -- Заказ Frank 2 телевизора
(7, 7, 1, 700),   -- Заказ Grace холодильник
(8, 8, 3, 300),   -- Заказ Henry 3 офисных кресла
(9, 9, 2, 500),   -- Заказ Stepan 2 стола
(10, 10, 4, 39.99), -- Заказ Stepan 4 книги
(1, 1, 1, 500),   -- Доп. заказ Alice еще один ноутбук
(2, 2, 2, 1500),  -- Доп. заказ Bob 2 телевизора
(3, 3, 1, 900),   -- Доп. заказ Charlie холодильник
(4, 4, 1, 150);   -- Доп. заказ David кресло

-- Вставка данных в таблицу корзины
INSERT INTO cart (user_id, product_id, quantity) VALUES
(1, 1, 1),  -- Пользователь 1 добавляет 1 Laptop в корзину
(2, 2, 2),  -- Пользователь 2 добавляет 2 Smartphone в корзину
(3, 3, 1),  -- Пользователь 3 добавляет 1 Washing Machine в корзину
(4, 4, 1),  -- Пользователь 4 добавляет 1 Sofa в корзину
(1, 5, 1),  -- Пользователь 1 добавляет 1 Tablet в корзину
(2, 6, 1),  -- Пользователь 2 добавляет 1 TV в корзину
(3, 7, 2),  -- Пользователь 3 добавляет 2 Novel в корзину
(4, 8, 1),  -- Пользователь 4 добавляет 1 Football в корзину
(5, 9, 3),  -- Пользователь 5 добавляет 3 Notebook в корзину
(1, 10, 1); -- Пользователь 1 добавляет 1 Gardening Kit в корзину

-- Вставка данных в таблицу избранных товаров
INSERT INTO favorite (user_id, product_id) VALUES
(1, 1),  -- Пользователь 1 добавляет Laptop в избранное
(2, 2),  -- Пользователь 2 добавляет Smartphone в избранное
(3, 3),  -- Пользователь 3 добавляет Washing Machine в избранное
(4, 4),  -- Пользователь 4 добавляет Sofa в избранное
(5, 5),  -- Пользователь 5 добавляет Tablet в избранное
(1, 6),  -- Пользователь 1 добавляет TV в избранное
(2, 7),  -- Пользователь 2 добавляет Refrigerator в избранное
(3, 8),  -- Пользователь 3 добавляет Office Chair в избранное
(4, 9),  -- Пользователь 4 добавляет Desk в избранное
(5, 10); -- Пользователь 5 добавляет Novel в избранное

-- Создание индексов для оптимизации
CREATE INDEX idx_user_id ON user(user_id);
CREATE INDEX idx_product_id ON product(product_id);
CREATE INDEX idx_order_id ON order(order_id);


-- Общая сумма продаж по поставщикам за год
SELECT
    s.name AS supplier_name,
    SUM(od.unit_price * od.quantity) AS total_sales
FROM
    supplier AS s
JOIN
    product AS p ON s.supplier_id = p.supplier_id
JOIN
    order_detail AS od ON p.product_id = od.product_id
JOIN
    "order" AS o ON od.order_id = o.order_id
WHERE
    o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY
    s.name;

-- Количество проданных товаров по типам
SELECT
    pt.name AS type_name,
    COUNT(od.product_id) AS items_sold
FROM
    product_type AS pt
JOIN
    product AS p ON pt.type_id = p.type_id
JOIN
    order_detail AS od ON p.product_id = od.product_id
GROUP BY
    pt.name;

-- Статус заказов пользователей
SELECT
    u.name AS user_name,
    o.order_date,
    o.status
FROM
    "user" AS u
JOIN
    "order" AS o ON u.user_id = o.user_id
ORDER BY
    o.order_date DESC;

-- Создание материализованного представления для суммарных продаж
CREATE MATERIALIZED VIEW supplier_sales_view AS
SELECT
    s.name AS supplier_name,
    SUM(od.unit_price * od.quantity) AS total_sales
FROM
    supplier AS s
JOIN
    product AS p ON s.supplier_id = p.supplier_id
JOIN
    order_detail AS od ON p.product_id = od.product_id
GROUP BY
    s.name;

-- Добавление колонки для атрибутов товаров
ALTER TABLE product ADD COLUMN product_attributes JSON;

-- Просмотр данных из представления
SELECT * FROM supplier_sales_view;
REFRESH MATERIALIZED VIEW supplier_sales_view;

-- Создание процедуры для обработки заказа
CREATE OR REPLACE PROCEDURE process_order(p_order_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "order"
    SET status = 'Processed'
    WHERE order_id = p_order_id;
END;
$$;

-- Вызов процедуры для обработки конкретного заказа
CALL process_order(1);

-- Проверка статуса заказа
SELECT order_id, status
FROM "order"
WHERE order_id = 1;

-- Топ-5 самых продаваемых товаров
SELECT
    p.name,
    SUM(od.quantity) AS total_sold
FROM
    product AS p
JOIN
    order_detail AS od ON p.product_id = od.product_id
GROUP BY
    p.name
ORDER BY
    total_sold DESC
LIMIT 5;

-- Общая прибыль по типам товаров
SELECT
    pt.name AS type_name,
    SUM(od.unit_price * od.quantity) AS total_profit
FROM
    product_type AS pt
JOIN
    product AS p ON pt.type_id = p.type_id
JOIN
    order_detail AS od ON p.product_id = od.product_id
GROUP BY
    pt.name
ORDER BY
    total_profit DESC;

-- Статистика по пользователям (количество заказов и общая сумма)
SELECT
    u.name AS user_name,
    COUNT(o.order_id) AS total_orders,
    SUM(od.unit_price * od.quantity) AS total_spent
FROM
    "user" AS u
LEFT JOIN -- Чтобы включить всех пользователей, даже у которых нет заказов
    "order" AS o ON u.user_id = o.user_id
LEFT JOIN
    order_detail AS od ON o.order_id = od.order_id
GROUP BY
    u.name
ORDER BY
    total_spent DESC;

-- Заказы с деталями и статусами
SELECT
    o.order_id,
    u.name AS user_name,
    o.order_date,
    o.status,
    p.name AS product_name,
    od.quantity,
    od.unit_price
FROM
    "order" AS o
JOIN
    "user" AS u ON o.user_id = u.user_id
JOIN
    order_detail AS od ON o.order_id = od.order_id
JOIN
    product AS p ON od.product_id = p.product_id
ORDER BY
    o.order_date DESC;

-- Средняя цена товаров по брендам
SELECT
    b.name AS brand_name,
    ROUND(AVG(p.price), 2) AS average_price
FROM
    brand AS b
JOIN
    product AS p ON b.brand_id = p.brand_id
GROUP BY
    b.name
ORDER BY
    average_price DESC;

-- Сравнение статуса заказов по пользователям
SELECT
    u.name AS user_name,
    o.status,
    COUNT(o.order_id) AS order_count
FROM
    "user" AS u
LEFT JOIN
    "order" AS o ON u.user_id = o.user_id
GROUP BY
    u.name, o.status
ORDER BY
    u.name, o.status;

-- Самые активные пользователи по количеству заказов
SELECT
    u.name AS user_name,
    COUNT(o.order_id) AS total_orders
FROM
    "user" AS u
JOIN
    "order" AS o ON u.user_id = o.user_id
GROUP BY
    u.name
ORDER BY
    total_orders DESC
LIMIT 5;
