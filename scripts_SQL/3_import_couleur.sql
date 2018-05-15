-- Table couleur : stocke toutes les couleurs de vin
CREATE TABLE t_couleur_import (
  i_libelle_couleur VARCHAR(30) NOT NULL,
  i_information_couleur VARCHAR(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_couleur_csv.csv'
INTO TABLE t_couleur_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

