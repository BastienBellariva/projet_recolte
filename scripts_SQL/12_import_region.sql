-- On crée la table stockant toutes les regions avec la correspondance des départements
CREATE TABLE t_region_import (
    i_numero_departement VARCHAR(4) NOT NULL,
    i_libelle_departement VARCHAR(50) NOT NULL,
    i_numero_region VARCHAR(4) NOT NULL,
    i_libelle_region VARCHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_region_csv.csv'
INTO TABLE t_region_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Création de la table région
CREATE TABLE t_region (
    id_region INT(4) NOT NULL AUTO_INCREMENT,
    numero_region VARCHAR(4) NOT NULL,
    libelle_region VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_region PRIMARY KEY(id_region)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- On ajoute la colonne id_region à la table t_departement et la clé étrangère
ALTER TABLE t_departement
ADD COLUMN id_region INT(4);

ALTER TABLE t_departement
ADD CONSTRAINT fk_id_region FOREIGN KEY(id_region) REFERENCES t_region(id_region);

-- On insert les valeurs dans la table region
INSERT INTO t_region (
    numero_region,
    libelle_region )
    SELECT DISTINCT
        i_numero_region,
        i_libelle_region
    FROM t_region_import;

-- On realise la jonction entre les départements et les region à travers les id
UPDATE t_departement AS d
SET id_region =
    (SELECT r.id_region
    FROM t_region AS r
    INNER JOIN t_region_import AS i ON r.numero_region = i.i_numero_region
    WHERE d.numero_departement = i.i_numero_departement
    AND i.i_numero_region = r.numero_region 
LIMIT 1);
