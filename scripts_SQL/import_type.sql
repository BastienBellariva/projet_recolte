-- Table type : stocke tous les types de vin
CREATE TABLE t_type (
  id_type INT(4) NOT NULL AUTO_INCREMENT,
  libelle_type VARCHAR(30) NOT NULL,
  infomation_type VARCHAR(50) NOT NULL,
  CONSTRAINT pk_id_type PRIMARY KEY(id_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_type_csv.csv' INTO
TABLE t_type
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';