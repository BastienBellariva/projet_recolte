-- On crée la table stockant tous les cépages des appellations
CREATE TABLE t_cepage_appellation_import (
    i_libelle_appellation VARCHAR(50) NOT NULL,
    i_code_cepage VARCHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../../source/import_cepage_appellation_csv.csv'
INTO TABLE t_cepage_appellation_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Création de la table de jonction entre les cépages et les appellations
CREATE TABLE t_cepage_appellation (
    id_cepage_appellation INT(4) NOT NULL AUTO_INCREMENT,
    id_cepage INT(4) NOT NULL,
    id_appellation INT(4) NOT NULL,
    CONSTRAINT pk_cepage_appellation PRIMARY KEY(id_cepage_appellation),
        CONSTRAINT fk_id_cepage FOREIGN KEY(id_cepage) REFERENCES t_cepage(id_cepage),
        CONSTRAINT fk_id_appellation_cepage FOREIGN KEY(id_appellation) REFERENCES t_appellation(id_appellation)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Création de la table temporaire pour gérer les liens entre départements et appellations
CREATE TABLE t_tmp_cepage_appellation (
    tmp_id_cepage_appellation INT(4) NOT NULL AUTO_INCREMENT,
    tmp_code_cepage VARCHAR(50) NOT NULL,
    tmp_libelle_appellation VARCHAR(50) NOT NULL,
    tmp_id_cepage INT(4),
    tmp_id_appellation INT(4),
    CONSTRAINT pk_tmp_id_cepage_appellation PRIMARY KEY(tmp_id_cepage_appellation)   
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de la table temporaire
INSERT INTO t_tmp_cepage_appellation (
    tmp_code_cepage,
    tmp_libelle_appellation )
    SELECT
        i_code_cepage,
        i_libelle_appellation
    FROM t_cepage_appellation_import;

-- Mise en lien des cepages avec les ID pour les jointures
UPDATE t_tmp_cepage_appellation AS tmp
SET tmp_id_cepage =
    (SELECT id_cepage
    FROM t_cepage AS c
    WHERE tmp.tmp_code_cepage = c.code_cepage);

-- Mise en lien des appellations avec les ID pour les jointures
UPDATE t_tmp_cepage_appellation AS tmp
SET tmp_id_appellation =
    (SELECT id_appellation
    FROM t_appellation AS a
    WHERE tmp.tmp_libelle_appellation = a.libelle_appellation);

-- On insert tous les résultats dans la table finale
INSERT INTO t_cepage_appellation (
    id_cepage,
    id_appellation )
    SELECT
        tmp_id_cepage,
        tmp_id_appellation
    FROM t_tmp_cepage_appellation;

-- On supprime les tables imports et temporaires
DROP TABLE t_tmp_cepage_appellation;
DROP TABLE t_cepage_appellation_import;
