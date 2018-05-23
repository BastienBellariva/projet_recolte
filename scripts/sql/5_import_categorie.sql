-- On crée la table stockant tous les categories contenus dans le CSV, sans vérification.
CREATE TABLE t_categorie_import (
  i_libelle_categorie VARCHAR(30) NOT NULL,
  i_infomation_categorie VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_categorie_csv.csv' 
INTO TABLE t_categorie_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Creation de la table t_categorie finale et propre, avec ID
CREATE TABLE t_categorie (
  id_categorie INT(4) NOT NULL AUTO_INCREMENT,
  libelle_categorie VARCHAR(30) NOT NULL,
  information_categorie VARCHAR(50) NOT NULL,
  CONSTRAINT pk_id_categorie PRIMARY KEY(id_categorie)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de cette table à partir de la table import
INSERT INTO t_categorie (
  libelle_categorie,
  information_categorie )
SELECT DISTINCT
  i_libelle_categorie,
  i_infomation_categorie
FROM t_categorie_import;

-- On supprime la table t_categorie_import car elle n'est plus utile
DROP TABLE t_categorie_import;