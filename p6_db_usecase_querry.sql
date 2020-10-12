-- USE CASE RECHERCHE PRODUIT

SELECT
	product.name,
    product.price,
    category.name AS category_name    
FROM  p6_db.product
JOIN p6_db.category
ON p6_db.product.category_id = p6_db.category.id
WHERE category.name = "boisson";

-- USE CASE CONSTITUER PANIER
-- On verifie ici la disponibilité de stock d'une pizzeria
-- donnée, pour un produit donné

SELECT
	thestock.ingredient_name AS ingredient_name,
	receipt.quantity AS receipt_quantity_need,
	thestock.stock_quantity
FROM  p6_db.receipt
JOIN p6_db.product
ON  p6_db.receipt.product_id = p6_db.product.id
JOIN
(SELECT 
	ingredient.name AS ingredient_name,
	stock.ingredient_id AS ingre,
	restaurant.name AS restaurant_name,
	stock.quantity AS stock_quantity
FROM p6_db.stock
JOIN p6_db.ingredient
ON p6_db.ingredient.id = p6_db.stock.ingredient_id
JOIN p6_db.restaurant
ON p6_db.restaurant.id = p6_db.stock.restaurant_id) AS thestock
ON receipt.ingredient_id = thestock.ingre
WHERE p6_db.product.name = "Margherita" AND
	thestock.restaurant_name = "OC Pizza Paris14";


-- USE CASE IDENTIFICATION
-- On vérifie ici qu' un utilisateur est existe bel et bien
-- dans la BDD pour des identifiants donné

SELECT
	user.first_name,
	user.last_name,
	user.email,
	role.name AS role_name,
	address.street_number,
	address.street_name,
	address.city_name
FROM p6_db.user
JOIN p6_db.role
ON user.role_id = role.id
JOIN p6_db.address
ON user.address_id = address.id
WHERE user.email = "rajat_dipomodoro@fakeemail.com"
AND user.password = "yyyyy";


-- USE CASE GESTION INGREDIENT
-- On ajoute ici un ingrédient à la liste.

INSERT INTO p6_db.ingredient
(name, unit_id)
VALUES
("origan",(SELECT unit.id
 	FROM p6_db.unit
 	WHERE unit.name ="gramme"));

-- Pour supprimer cet ingrédient si besoin.
DELETE FROM p6_db.ingredient
WHERE ingredient.name ="origan";

--Visualistaion
SELECT
ingredient.name AS ingredient_name,
unit.name AS ingredient_unit
FROM p6_db.ingredient
JOIN p6_db.unit
ON ingredient.unit_id = unit.id;



-- USE CASE GESTION DE STOCK

--Intro: Visualistaion des lignes de commande
--d'une commande
SELECT
order.order_number AS order_number,
product.name AS product_name,
orderline.quantity AS product_quantity
FROM p6_db.orderline
JOIN p6_db.product
ON orderline.product_id = product.id
JOIN p6_db.order
ON orderline.order_id = order.id
WHERE order.order_number = 2;

-- On regardre maintenant les ingrédient de stock impacté par
-- cette commande en regard du stock disponible.
SELECT
b.order_number AS order_number,
restaurant.name AS restaurant_name,
sum(b.product_quantity) AS product_quantity,
b.ingredient_name AS ingredient_name,
b.ingredient_quantity AS ingredient_quantity,
stock.quantity AS stock_quantity
FROM p6_db.stock
JOIN(
	SELECT
	receipt.product_id AS product_id,
	receipt.ingredient_id AS ingredient_id,
	receipt.quantity AS ingredient_quantity,
	ingredient.name AS ingredient_name,
	a.restaurant_id AS restaurant_id,
	a.product_quantity AS product_quantity,
	a.order_number AS order_number
	FROM p6_db.receipt
	JOIN (
		SELECT
		order.order_number AS order_number,
		order.restaurant_id AS restaurant_id,
		orderline.order_id AS order_id,
		orderline.quantity AS product_quantity,
		orderline.product_id AS product_id
		FROM p6_db.orderline
		JOIN p6_db.product
		ON orderline.product_id = product.id
		JOIN p6_db.order
		ON orderline.order_id = order.id) AS a
	ON receipt.product_id = a.product_id
	JOIN p6_db.ingredient
	ON receipt.ingredient_id = ingredient.id) AS b
ON stock.ingredient_id = b.ingredient_id
JOIN p6_db.restaurant
ON stock.restaurant_id = restaurant.id
WHERE b.order_number = 2 AND
b.restaurant_id= restaurant.id
GROUP BY b.order_number,
restaurant.name,
b.ingredient_name,
b.ingredient_quantity,
stock.quantity
ORDER BY b.ingredient_name ASC;


--MAJ
UPDATE p6_db.stock
JOIN p6_db.restaurant
ON stock.restaurant_id = restaurant.id
JOIN
	(SELECT
		sum(b.product_quantity) * b.ingredient_quantity AS stock_quantity_update,
		b.restaurant_id AS restaurant_id,
		b.ingredient_id AS ingredient_id,
		b.order_number AS order_number
	FROM (
		SELECT
			receipt.product_id AS product_id,
			receipt.ingredient_id AS ingredient_id,
			receipt.quantity AS ingredient_quantity,
			ingredient.name AS ingredient_name,
			a.restaurant_id AS restaurant_id,
			a.product_quantity AS product_quantity,
			a.order_number AS order_number
		FROM p6_db.receipt
		JOIN (
			SELECT
				order.order_number AS order_number,
				order.restaurant_id AS restaurant_id,
				orderline.order_id AS order_id,
				orderline.quantity AS product_quantity,
				orderline.product_id AS product_id
			FROM p6_db.orderline
			JOIN p6_db.product
			ON orderline.product_id = product.id
			JOIN p6_db.order
			ON orderline.order_id = order.id
		) AS a
		ON receipt.product_id = a.product_id
		JOIN p6_db.ingredient
		ON receipt.ingredient_id = ingredient.id
		) AS b
		GROUP BY b.ingredient_quantity,
		b.ingredient_id,
		b.restaurant_id,
		b.order_number
	) AS c
ON stock.ingredient_id = c.ingredient_id
SET stock.quantity = stock.quantity - c.stock_quantity_update
WHERE c.order_number = 2 AND
c.restaurant_id = restaurant.id AND
c.ingredient_id = stock.ingredient_id;