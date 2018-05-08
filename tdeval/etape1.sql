-- etape 1 et 2 
DROP TABLE IF EXISTS etablissement;

CREATE TABLE `etablissement`(
`id_etablissement` VARCHAR(8),
`libelle_etablissement` VARCHAR(126) NOT NULL,
`sigle_etablissement` VARCHAR(26),
`type_etablissement` SMALLINT(2),
`secteur_etablissement` SMALLINT(2),
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
`2015-2016` INT(5),
CONSTRAINT pk_id_etablissement PRIMARY KEY(id_etablissement)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS secteur;

CREATE TABLE `secteur`(
`id_secteur` SMALLINT(2) AUTO_INCREMENT,
`libelle_secteur` VARCHAR(6),
CONSTRAINT pk_id_secteur PRIMARY KEY(id_secteur)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS type;

CREATE TABLE `type`(
`id_type` SMALLINT(2) AUTO_INCREMENT,
`libelle_type` VARCHAR(78),
CONSTRAINT pk_id_type PRIMARY KEY(id_type)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

ALTER TABLE etablissement
ADD CONSTRAINT fk_type_etablissement FOREIGN KEY (type_etablissement)
REFERENCES type(id_type);

ALTER TABLE etablissement
ADD CONSTRAINT fk_secteur_etablissement FOREIGN KEY (secteur_etablissement)
REFERENCES secteur(id_secteur);

INSERT INTO type (libelle_type) SELECT DISTINCT (type_etablissement) FROM t_ees_import;

INSERT INTO secteur (libelle_secteur) SELECT DISTINCT (secteur_activite) FROM t_ees_import;

INSERT INTO etablissement (
`id_etablissement`,
`libelle_etablissement`,
`sigle_etablissement`,
`rattachement`,
`localisation`,
`code_commune`,
`libelle_commune`,
`unite_urbaine`,
`departement`,	
`academie`,
`region`,
`adresse`,
`code_postal`,
`localite`,
`pays`,
`libelle_programme_chef_file`,
`2010-2011`,
`2011-2012`,
`2012-2013`,
`2013-2014`,
`2014-2015`,
`2015-2016`) 
SELECT 
`uai_identifiant`,
`libelle_etablissement`,
`sigle_etablissement`,
`rattachement`,
`localisation`,
`code_commune`,
`libelle_commune`,
`unite_urbaine`,
`departement`,
`academie`,
`region`,
`adresse`,
`code_postal`,
`localite`,
`pays`,
`libelle_programme_chef_file`,
`2010-2011`,
`2011-2012`,
`2012-2013`,
`2013-2014`,
`2014-2015`,
`2015-2016` FROM t_ees_import;

DROP TABLE IF EXISTS tmp_secteur;
CREATE TABLE `tmp_secteur`(
`tmp_id` VARCHAR(8),
`tmp_libelle`VARCHAR(78),
`tmp_id_secteur`SMALLINT(2)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

INSERT INTO tmp_secteur (tmp_id, tmp_libelle)
SELECT uai_identifiant, secteur_activite
FROM t_ees_import;

UPDATE tmp_secteur
SET tmp_id_secteur = (SELECT id_secteur
FROM secteur
WHERE
TRIM(tmp_secteur.tmp_libelle)=TRIM(secteur.libelle_secteur));

UPDATE etablissement
SET secteur_etablissement = (SELECT tmp_id_secteur
FROM tmp_secteur
WHERE tmp_id = id_etablissement);

DROP TABLE tmp_secteur;

DROP TABLE IF EXISTS tmp_type;
CREATE TABLE `tmp_type`(
`tmp_id` VARCHAR(8),
`tmp_libelle`VARCHAR(78),
`tmp_id_type`SMALLINT(2)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

INSERT INTO tmp_type (tmp_id, tmp_libelle)
SELECT uai_identifiant, type_etablissement
FROM t_ees_import;

UPDATE tmp_type
SET tmp_id_type = (SELECT id_type
FROM type
WHERE
TRIM(tmp_type.tmp_libelle)=TRIM(type.libelle_type));

UPDATE etablissement
SET type_etablissement = (SELECT tmp_id_type
FROM tmp_type
WHERE tmp_id = id_etablissement);

DROP TABLE tmp_type;

SELECT e.libelle_etablissement, s.libelle_secteur FROM etablissement e, secteur s WHERE s.id_secteur = e.secteur_etablissement AND s.libelle_secteur = 'Public'; 
SELECT e.libelle_etablissement, s.libelle_secteur FROM etablissement e, secteur s WHERE s.id_secteur = e.secteur_etablissement AND s.libelle_secteur = 'Privé'; 

SELECT e.libelle_etablissement, t.libelle_type FROM etablissement e, type t WHERE t.id_type = e.type_etablissement AND t.libelle_type = 'Université';




