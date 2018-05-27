-- On crée la table stockant tous les cépages des appellations
CREATE TABLE t_type_appellation_import (
    i_libelle_appellation VARCHAR(50) NOT NULL,
    i_code_type VARCHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../../source/import_type_appellation_csv.csv'
INTO TABLE t_type_appellation_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Création de la table de jonction entre les cépages et les appellations
CREATE TABLE t_type_appellation (
    id_type_appellation INT(4) NOT NULL AUTO_INCREMENT,
    id_type INT(4) NOT NULL,
    id_appellation INT(4) NOT NULL,
    CONSTRAINT pk_type_appellation PRIMARY KEY(id_type_appellation),
        CONSTRAINT fk_type_appellation_type FOREIGN KEY(id_type) REFERENCES t_type(id_type),
        CONSTRAINT fk_type_appellation_appellation FOREIGN KEY(id_appellation) REFERENCES t_appellation(id_appellation)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Création de la table temporaire pour gérer les liens entre départements et appellations
CREATE TABLE t_tmp_type_appellation (
    tmp_id_type_appellation INT(4) NOT NULL AUTO_INCREMENT,
    tmp_code_type VARCHAR(50) NOT NULL,
    tmp_libelle_appellation VARCHAR(50) NOT NULL,
    tmp_id_type INT(4),
    tmp_id_appellation INT(4),
    CONSTRAINT pk_tmp_id_type_appellation PRIMARY KEY(tmp_id_type_appellation)   
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de la table temporaire
INSERT INTO t_tmp_type_appellation (
    tmp_code_type,
    tmp_libelle_appellation )
    SELECT
        i_code_type,
        i_libelle_appellation
    FROM t_type_appellation_import;

-- Mise en lien des types avec les ID pour les jointures
UPDATE t_tmp_type_appellation AS tmp
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE tmp.tmp_code_type = c.code_type);

-- Mise en lien des appellations avec les ID pour les jointures
UPDATE t_tmp_type_appellation AS tmp
SET tmp_id_appellation =
    (SELECT id_appellation
    FROM t_appellation AS a
    WHERE tmp.tmp_libelle_appellation = a.libelle_appellation);

-- On insert tous les résultats dans la table finale
INSERT INTO t_type_appellation (
    id_type,
    id_appellation )
    SELECT
        tmp_id_type,
        tmp_id_appellation
    FROM t_tmp_type_appellation;

-- On supprime les tables imports et temporaires
DROP TABLE t_tmp_type_appellation;
DROP TABLE t_type_appellation_import;
