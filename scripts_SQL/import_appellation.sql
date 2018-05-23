-- On crée la table stockant toutes les appellations
CREATE TABLE t_appellation_import (
    i_libelle_appellation VARCHAR(50) NOT NULL,
    i_libelle_departement VARCHAR(80) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_appellation_csv.csv'
INTO TABLE t_appellation_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Création de la table appellation
CREATE TABLE t_appellation (
    id_appellation INT(4) NOT NULL AUTO_INCREMENT,
    libelle_appellation VARCHAR (50) NOT NULL,
    description_appellation TEXT,
    CONSTRAINT pk_id_appellation PRIMARY KEY(id_appellation)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Création de la table de jonction entre departements et appellations
CREATE TABLE t_appellation_departement (
    id_appellation_departement INT(4) NOT NULL AUTO_INCREMENT,
    id_appellation INT(4) NOT NULL,
    id_departement INT(4) NOT NULL,
    CONSTRAINT pk_id_appellation_departement PRIMARY KEY(id_appellation_departement),
        CONSTRAINT fk_id_appellation FOREIGN KEY(id_appellation) REFERENCES t_appellation(id_appellation),
        CONSTRAINT fk_id_departement FOREIGN KEY(id_departement) REFERENCES t_departement(id_departement)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Cration de la table temporaire pour gérer les liens entre départemenents et appellations
CREATE TABLE t_tmp_appellation_departement (
    tmp_id_appellation_departement INT(4) NOT NULL AUTO_INCREMENT,
    tmp_libelle_appellation VARCHAR(50) NOT NULL,
    tmp_libelle_departement VARCHAR(80) NOT NULL,
    tmp_id_appellation INT(4),
    tmp_id_departement INT(4),
    CONSTRAINT pk_id_tmp_appellation_departement PRIMARY KEY(tmp_id_appellation_departement)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Remplissage de la table appellation
INSERT INTO t_appellation (
    libelle_appellation )
    SELECT DISTINCT
        i_libelle_appellation
    FROM t_appellation_import;

-- Remplissage de la table temporaire
INSERT INTO t_tmp_appellation_departement (
    tmp_libelle_appellation,
    tmp_libelle_departement )
    SELECT
        i_libelle_appellation,
        i_libelle_departement
    FROM t_appellation_import;

-- Mise en lien des appellations avec les ID pour les jonctions
UPDATE t_tmp_appellation_departement AS tmp
SET tmp_id_appellation =
    (SELECT id_appellation
    FROM t_appellation AS a
    WHERE tmp.tmp_libelle_appellation = a.libelle_appellation);

-- Mise en lien des départements avec les ID pour les jonctions
UPDATE t_tmp_appellation_departement AS tmp
SET tmp_id_departement =
    (SELECT id_departement
    FROM t_departement AS d
    WHERE tmp.tmp_libelle_departement = d.libelle_departement);

-- On insert tous les résultats dans la table finale
INSERT INTO t_appellation_departement (
    id_appellation,
    id_departement )
    SELECT
        tmp_id_appellation,
        tmp_id_departement
    FROM t_tmp_appellation_departement;
