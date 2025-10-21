-- 02_shop_mock_data.sql: insertion des données de mock pour shop_service

-- S'assurer que nous sommes dans la bonne base
\connect shop_service;

-- Insert units (explicit ids to match given data)
INSERT INTO units (id, code, label) VALUES
  (1, 'kg', 'Kilogram'),
  (2, 'L', 'Liter'),
  (3, 'piece', 'Piece')
ON CONFLICT DO NOTHING;

-- Insert certifications
INSERT INTO product_certification (id, label) VALUES
  (1, 'Organic'),
  (2, 'PDO'),
  (3, 'Red Label'),
  (4, 'Fair Trade')
ON CONFLICT DO NOTHING;

-- Insert categories
INSERT INTO product_category (id, label) VALUES
  (1, 'Fruits'),
  (2, 'Vegetables'),
  (3, 'Meats'),
  (4, 'Dairy Products'),
  (5, 'Beverages')
ON CONFLICT DO NOTHING;

-- Insert products
INSERT INTO product (id, name, description, unit_price, is_active, is_fresh, unit_id, category_id) VALUES
  (1, 'Apple', 'Local red apple', 2.50, true, true, 3, 1),
  (2, 'Banana', 'Imported organic banana', 2.80, true, true, 3, 1),
  (3, 'Tomato', 'Beef heart tomato', 3.20, true, true, 1, 2),
  (4, 'Carrot', 'Sand-grown carrot', 1.90, true, true, 1, 2),
  (5, 'Ground beef', '5% fat beef', 12.00, true, true, 1, 3),
  (6, 'Whole milk', 'Pasteurized farm milk', 1.50, true, true, 2, 4),
  (7, 'Plain yogurt', 'Cow milk yogurt', 3.80, true, true, 3, 4),
  (8, 'Orange juice', '100% pure fruit juice', 4.50, true, false, 2, 5)
ON CONFLICT DO NOTHING;

-- Insert product <-> certification relations
INSERT INTO product_certification_rel (product_id, certification_id) VALUES
  (1, 1),
  (2, 1),
  (3, 3),
  (4, 1),
  (6, 1),
  (8, 4)
ON CONFLICT DO NOTHING;

-- Ensure sequences are set to a value higher than the max id so future inserts work
DO $$
BEGIN
  PERFORM setval(pg_get_serial_sequence('units','id'), COALESCE((SELECT MAX(id) FROM units), 1));
  PERFORM setval(pg_get_serial_sequence('product_certification','id'), COALESCE((SELECT MAX(id) FROM product_certification), 1));
  PERFORM setval(pg_get_serial_sequence('product_category','id'), COALESCE((SELECT MAX(id) FROM product_category), 1));
  PERFORM setval(pg_get_serial_sequence('product','id'), COALESCE((SELECT MAX(id) FROM product), 1));
END$$;
-- 01_shop_init.sql: création des bases de données et du schéma (tables)

CREATE DATABASE shop_service;
CREATE DATABASE user_service;

-- Se connecter à la base shop_service pour créer le schéma
\connect shop_service;

-- Units
CREATE TABLE IF NOT EXISTS units (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) NOT NULL,
  label VARCHAR(255) NOT NULL
);

-- Product certifications
CREATE TABLE IF NOT EXISTS product_certification (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255) NOT NULL
);

-- Product categories
CREATE TABLE IF NOT EXISTS product_category (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255) NOT NULL
);

-- Products
CREATE TABLE IF NOT EXISTS product (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  unit_price NUMERIC(10,2) NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT true,
  is_fresh BOOLEAN NOT NULL DEFAULT false,
  unit_id INTEGER NOT NULL REFERENCES units(id) ON DELETE RESTRICT,
  category_id INTEGER NOT NULL REFERENCES product_category(id) ON DELETE RESTRICT
);

-- Many-to-many: product <-> certification
CREATE TABLE IF NOT EXISTS product_certification_rel (
  product_id INTEGER NOT NULL REFERENCES product(id) ON DELETE CASCADE,
  certification_id INTEGER NOT NULL REFERENCES product_certification(id) ON DELETE CASCADE,
  PRIMARY KEY (product_id, certification_id)
);

