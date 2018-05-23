-- On crée la table stockant tous les types contenus dans le CSV, sans vérification.
CREATE TABLE t_type_import (
  i_libelle_type VARCHAR(30) NOT NULL,
  i_infomation_type VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_type_csv.csv' 
INTO TABLE t_type_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Creation de la table t_type finale et propre, avec ID
CREATE TABLE t_type (
  id_type INT(4) NOT NULL AUTO_INCREMENT,
  libelle_type VARCHAR(30) NOT NULL,
  information_type VARCHAR(50) NOT NULL,
  CONSTRAINT pk_id_type PRIMARY KEY(id_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de cette table à partir de la table import
INSERT INTO t_type (
  libelle_type,
  information_type )
SELECT DISTINCT
  i_libelle_type,
  i_infomation_type
FROM t_type_import;