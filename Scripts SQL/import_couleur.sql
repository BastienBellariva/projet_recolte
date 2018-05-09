-- Table couleur : stocke toutes les couleurs de vin
CREATE TABLE t_couleur (
  id_couleur INT(4) NOT NULL AUTO_INCREMENT,
  libelle_couleur VARCHAR(30) NOT NULL,
  information_couleur VARCHAR(80) NOT NULL,
  CONSTRAINT pk_id_couleur PRIMARY KEY(id_couleur)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_couleur_csv.csv' INTO
TABLE t_couleur
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

