-- 01_shop_init.sql: création des bases de données et du schéma (tables)
-- Se connecter à la base shop_service pour créer le schéma
\connect shop_service;

-- Table des unités de mesure
CREATE TABLE IF NOT EXISTS units (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) NOT NULL,
  label VARCHAR(255) NOT NULL
);

-- Table des certifications produits
CREATE TABLE IF NOT EXISTS product_certification (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255) NOT NULL
);

-- Table des catégories de produits
CREATE TABLE IF NOT EXISTS product_category (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255) NOT NULL
);

-- Table des produits
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

-- Table de liaison many-to-many entre produits et certifications
CREATE TABLE IF NOT EXISTS product_certification_rel (
  product_id INTEGER NOT NULL REFERENCES product(id) ON DELETE CASCADE,
  certification_id INTEGER NOT NULL REFERENCES product_certification(id) ON DELETE CASCADE,
  PRIMARY KEY (product_id, certification_id)
);


