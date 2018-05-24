-- On crée la table stockant tous les cépages contenues dans le CSV, sans vérification
CREATE TABLE t_cepage_import (
  i_code_cepage VARCHAR(30) NOT NULL,
  i_information_cepage VARCHAR(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../../source/import_cepage_csv.csv'
INTO TABLE t_cepage_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Création de la table t_cepage finale et propre, avec ID
CREATE TABLE t_cepage (
  id_cepage INT(4) NOT NULL AUTO_INCREMENT,
  code_cepage VARCHAR(30) NOT NULL,
  information_cepage VARCHAR(80) NOT NULL,
  CONSTRAINT pk_id_cepage PRIMARY KEY(id_cepage)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de cette table à partir de la table import
INSERT INTO t_cepage (
  code_cepage,
  information_cepage )
  SELECT DISTINCT
    i_code_cepage,
    i_information_cepage
  FROM t_cepage_import;

-- On supprime la table t_import car elle n'est plus utile
DROP TABLE t_cepage_import;
