-- Table département : stocke tous les départements de France
CREATE TABLE t_departement (
  id_departement INT(4) NOT NULL AUTO_INCREMENT, 
  numero_departement VARCHAR(4) NOT NULL,
  libelle_departement VARCHAR(30) NOT NULL,
  CONSTRAINT pk_id_departement PRIMARY KEY(id_departement)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_departement_csv.csv' INTO
TABLE t_departement
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';