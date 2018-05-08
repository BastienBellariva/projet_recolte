DROP TABLE IF EXISTS t_ees_import;
CREATE TABLE `t_ees_import`(
`uai_identifiant` VARCHAR(8),
`libelle_etablissement` VARCHAR(126),
`sigle_etablissement` VARCHAR(26),
`type_etablissement` VARCHAR(78),
`secteur_activite` VARCHAR(6),
`rattachement` VARCHAR(44),
`localisation` VARCHAR(74),
`code_commune` CHAR(5),
`libelle_commune` VARCHAR(24),
`unite_urbaine` VARCHAR(27),
`departement` VARCHAR(21),
`academie` VARCHAR(19),
`region` VARCHAR(26),
`adresse` VARCHAR(38),
`code_postal` CHAR(5),
`localite` VARCHAR(26),
`pays` VARCHAR(7),
`libelle_programme_chef_file` VARCHAR(102),
`2010-2011` INT(5),
`2011-2012` INT(5),
`2012-2013` INT(5),
`2013-2014` INT(5),
`2014-2015` INT(5),
`2015-2016` INT(5)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

LOAD DATA LOCAL INFILE '/home/poirot/MySQL/tdeval/Source/etablissements-es.csv' INTO
TABLE t_ees_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
