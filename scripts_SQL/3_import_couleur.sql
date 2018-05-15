-- On crée la table stockant toutes les couleurs contenues dans le CSV, sans vérification
CREATE TABLE t_couleur_import (
  i_libelle_couleur VARCHAR(30) NOT NULL,
  i_information_couleur VARCHAR(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_couleur_csv.csv'
INTO TABLE t_couleur_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Création de la table t_couleur finale et propre, avec ID
CREATE TABLE t_couleur (
  id_couleur INT(4) NOT NULL AUTO_INCREMENT,
  libelle_couleur VARCHAR(30) NOT NULL,
  information_couleur VARCHAR(80) NOT NULL,
  CONSTRAINT pk_id_couleur PRIMARY KEY(id_couleur)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de cette table à partir de la table import
INSERT INTO t_couleur (
  libelle_couleur
  information_couleur )
  SELECT DISTINCT
    i_libelle_couleur
    i_information_couleur
  FROM t_couleur_import
