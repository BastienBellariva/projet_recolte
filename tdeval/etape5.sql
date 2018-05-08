DROP TABLE IF EXISTS t_ees_journal;

CREATE TABLE `t_ees_journal` (
libelle VARCHAR(2) NOT NULL,
id_secteur_etablissement VARCHAR(10), 
id_type_etablissement VARCHAR(78), 
sigle VARCHAR(26))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS Updates;

DELIMITER $$
CREATE TRIGGER Updates BEFORE UPDATE
ON t_ees_import FOR EACH ROW
	BEGIN
	INSERT INTO t_ees_journal
	(libelle, secteur_etablissement, type_etablissement, sigle)
	VALUES(OLD.libelle_etablissement, OLD.secteur_activite, OLD.type_etablissement, OLD.sigle_etablissement);
	END $$
DELIMITER ;


/*UPDATE t_ees_import t
SET t.sigle_etablissement = 'TGU'
WHERE (`2015-2016`) > 40000;*/
