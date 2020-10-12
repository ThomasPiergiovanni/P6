INSERT INTO p6_db.address
(street_number,street_name, zip_code,city_name)
VALUES
("16", "Avenue Jean-Moulin", 75014, "Paris"),
("99b", "Avenue du Général Leclerc", 75007, "Paris"),
("65", "Rue de Lagny", 75020, "Paris"),
("80", "Rue de Wattignies", 75012, "Paris"),
("17", "Rue Baudin", 94200, "Ivry-sur-Seine"),
("40", "Avenue Laplace", 94110, "Arceuil"),
("55", "Rue du Faubourg Saint-Honoré", 75008, "Paris");

INSERT INTO p6_db.category
(name)
VALUES
("pizza"),
("boisson"),
("dessert");

INSERT INTO p6_db.status
(name)
VALUES
("Nouvelle"),
("En préparation"),
("Préparée"),
("En livraison"),
("Livrée"),
("Annulée");

INSERT INTO p6_db.unit
(name)
VALUES
("gramme"),
("centilitre"),
("unitaire");

INSERT INTO p6_db.ingredient
(name,unit_id)
VALUES
("pâtes à pizza", 1),
("sauce tomate", 2),
("jambon cuit", 1),
("mozzarella", 1),
("coca-cola", 3),
("champignon", 1);

INSERT INTO p6_db.role
(Name)
VALUES
("reponsable"),
("pizzaiolo"),
("livreur"),
("client"),
("visiteur");

INSERT INTO p6_db.user
(first_name,last_name,email, password,phone,role_id,address_id)
VALUES
("Alexandra", "Cheffeu","alexandra_cheffeu@fakeemail.com","xxxxx","5040302010", 1, 4 ),
("Rajat", "Di Pomodoro","rajat_dipomodoro@fakeemail.com","yyyyy","0150024003", 2, 6),
("Elodie", "Pasouvent","elodie_pasouvent@fakeemail.com","","1122334455", 5, 2),
("Hans", "Legourmand", "hans_legourmand@fakeemail.com","mmmmm","5544332211", 4, 3);

INSERT INTO p6_db.restaurant
(name,email, phone,address_id)
VALUES
("OC Pizza Paris14", "ocpizzaparis14@fakeemail.com", 75014, 1),
("OC Pizza Paris12", "ocpizzaparis12@fakeemail.com", 75012, 4);

INSERT INTO p6_db.order
(order_number,user_id,restaurant_id,address_id,status_id)
VALUES
("000000000001", 3, 1, 2, 1),
("000000000002", 3, 1, 2, 4),
("000000000003", 4, 2, 5, 5);

INSERT INTO p6_db.product
(name,price,category_id)
VALUES
("Margherita", 11.50, 1),
("Regina", 13.00, 1),
("Coca-Cola", 2, 2),
("Tiramisù", 3.50, 3);

INSERT INTO p6_db.orderline
(order_id,product_id,quantity)
VALUES
(1, 1, 1),
(1, 3, 1),
(2, 1, 2),
(2, 2, 1),
(2, 3, 3),
(2, 4, 3);

INSERT INTO p6_db.receipt
(product_id,ingredient_id,quantity)
VALUES
(1, 1, 100),
(1, 2, 20),
(1, 4, 50),
(2, 1, 100),
(2, 2, 20),
(2, 3, 20),
(2, 4, 50),
(2, 6, 10),
(3, 5, 1);

INSERT INTO p6_db.stock
(restaurant_id,ingredient_id, quantity )
VALUES
(1, 1, 10000),
(1, 2, 500),
(1, 3, 2000),
(1, 4, 3000),
(1, 5, 100),
(1, 6, 3000),
(2, 1, 5000),
(2, 2, 250),
(2, 3, 1000),
(2, 4, 1500),
(2, 5, 50),
(2, 6, 1500);
