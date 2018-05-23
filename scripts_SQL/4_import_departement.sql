-- On crée la table stockant tous les départements contenus dans le CSV, sans vérification.
CREATE TABLE t_departement_import (
  i_numero_departement VARCHAR(4) NOT NULL,
  i_libelle_departement VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_departement_csv.csv' INTO
TABLE t_departement_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Creation de la table t_departement finale et propre, avec ID
CREATE TABLE t_departement (
  id_departement INT(4) NOT NULL AUTO_INCREMENT,
  numero_departement VARCHAR(4) NOT NULL,
  libelle_departement VARCHAR(30) NOT NULL,
  CONSTRAINT pk_id_departement PRIMARY KEY(id_departement)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de cette table à partir de la table import
INSERT INTO t_departement (
  numero_departement,
  libelle_departement )
  SELECT DISTINCT
    i_numero_departement,
    i_libelle_departement
  FROM t_departement_import;
