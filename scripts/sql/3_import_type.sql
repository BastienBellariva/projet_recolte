-- On crée la table stockant tous les cépages contenues dans le CSV, sans vérification
CREATE TABLE t_type_import (
  i_code_type VARCHAR(10) NOT NULL,
  i_information_type VARCHAR(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../../source/import_type_csv.csv'
INTO TABLE t_type_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Création de la table t_type finale et propre, avec ID
CREATE TABLE t_type (
  id_type INT(4) NOT NULL AUTO_INCREMENT,
  code_type VARCHAR(10) NOT NULL,
  information_type VARCHAR(80) NOT NULL,
  CONSTRAINT pk_id_type PRIMARY KEY(id_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de cette table à partir de la table import
INSERT INTO t_type (
  code_type,
  information_type )
  SELECT DISTINCT
    i_code_type,
    i_information_type
  FROM t_type_import;

-- On supprime la table t_import car elle n'est plus utile
DROP TABLE t_type_import;
