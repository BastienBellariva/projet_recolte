-- Table temporaire pour lier les déclarations aux départements
CREATE TABLE t_tmp_declaration_recolte (
    id_tmp_declaration_recolte INT(4) NOT NULL AUTO_INCREMENT,
    tmp_nombre_declaration INT(4) NOT NULL,
    tmp_numero_departement VARCHAR(4) NOT NULL,
    tmp_id_departement INT(4),
    CONSTRAINT pk_id_tmp_declaration_recolte
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- On insert les vlaeurs qu'on veut dans notre table temporaire
INSERT INTO t_tmp_declaration_recolte (
    tmp_nombre_declaration,
    tmp_numero_departement )
    SELECT
        i_declaration_recolte,
        i_numero_departement
    FROM t_vigne_import;

-- On remplit le champs id_departement pour préparer la jointure
UPDATE t_tmp_declaration_recolte AS tmp
SET tmp_id_departement =
    (SELECT id_departement
    FROM t_departement AS d
    WHERE tmp.tmp_numero_departement = d.numero_departement);

-- On transfert les valeurs dans la table t_declaration_recolte
INSERT INTO t_declaration_recolte (
    nombre_declaration,
    id_departement )
    SELECT
        tmp_nombre_declaration,
        tmp_id_departement
    FROM t_tmp_declaration_recolte;

-- On supprime les tables temporaires
DROP TABLE t_tmp_declaration_recolte;