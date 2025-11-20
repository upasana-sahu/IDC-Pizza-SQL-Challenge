/* ---------------------------------------------------------
   IDC Pizza SQL Challenge – Full Solution
   Author: Upasana Sahu
   --------------------------------------------------------- */

/* =========================================================
   Q2: List all unique pizza categories
   ========================================================= */
SELECT DISTINCT category
FROM pizza_types;


/* =========================================================
   Q3: Display pizza_type_id, name, and ingredients 
       Replace NULL ingredients with "Missing Data"
   ========================================================= */
SELECT 
    pizza_type_id,
    name,
    COALESCE(ingredients, 'Missing Data') AS ingredients
FROM pizza_types
LIMIT 5;


/* =========================================================
   Q4: Check for pizzas missing a price
   ========================================================= */
SELECT *
FROM pizzas
WHERE price IS NULL;


/* =========================================================
   Q5: Orders placed on '2015-01-01'
   ========================================================= */
SELECT *
FROM orders
WHERE date = '2015-01-01';


/* =========================================================
   Q6: List pizzas with price in descending order
   ========================================================= */
SELECT *
FROM pizzas
ORDER BY price DESC;


/* =========================================================
   Q7: Pizzas sold in sizes 'L' or 'XL'
   ========================================================= */
SELECT *
FROM pizzas
WHERE size IN ('L', 'XL');


/* =========================================================
   Q8: Pizzas priced between $15.00 and $17.00
   ========================================================= */
SELECT *
FROM pizzas
WHERE price BETWEEN 15.00 AND 17.00;


/* =========================================================
   Q9: Pizzas with "Chicken" in the name
   ========================================================= */
SELECT *
FROM pizza_types
WHERE name LIKE '%Chicken%';


/* =========================================================
   Q10: Orders on '2015-02-15' OR placed after 8 PM
   ========================================================= */
SELECT *
FROM orders
WHERE date = '2015-02-15'
   OR time > '20:00:00';


/* =========================================================
   Q11: Total quantity of pizzas sold
   ========================================================= */
SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM order_details;


/* =========================================================
   Q12: Average pizza price
   ========================================================= */
SELECT 
    AVG(price) AS average_pizza_price
FROM pizzas;


/* =========================================================
   Q13: Total order value per order
   ========================================================= */
SELECT 
    od.order_id,
    SUM(od.quantity * p.price) AS order_total
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
GROUP BY od.order_id
ORDER BY od.order_id;


/* =========================================================
   Q14: Total quantity sold per pizza category
   ========================================================= */
SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;


/* =========================================================
   Q15: Categories with more than 5,000 pizzas sold
   ========================================================= */
SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
HAVING SUM(od.quantity) > 5000;


/* =========================================================
   Q16: Pizzas that were never ordered
   ========================================================= */
SELECT 
    p.pizza_id,
    pt.name AS pizza_name,
    pt.category,
    pt.ingredients,
    p.size,
    p.price,
    od.quantity
FROM pizzas p
LEFT JOIN order_details od 
    ON p.pizza_id = od.pizza_id
LEFT JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
WHERE od.order_id IS NULL;


/* =========================================================
   Q17: Price differences between sizes of the same pizza
   ========================================================= */
SELECT 
    p1.pizza_type_id,
    p1.size AS size_1,
    p1.price AS price_1,
    p2.size AS size_2,
    p2.price AS price_2,
    (p2.price - p1.price) AS price_difference
FROM pizzas p1
JOIN pizzas p2
    ON p1.pizza_type_id = p2.pizza_type_id
   AND p1.size < p2.size
ORDER BY p1.pizza_type_id;
