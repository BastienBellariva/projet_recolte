-- Table type : stocke tous les types de vin
CREATE TABLE t_type_import (
  libelle_type VARCHAR(30) NOT NULL,
  infomation_type VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_type_csv.csv' 
INTO TABLE t_type_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';