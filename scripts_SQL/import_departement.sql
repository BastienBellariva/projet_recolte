-- Table département : stocke tous les départements de France
CREATE TABLE t_departement_import (
  i_numero_departement VARCHAR(4) NOT NULL,
  i_libelle_departement VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_departement_csv.csv' INTO
TABLE t_departement_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';