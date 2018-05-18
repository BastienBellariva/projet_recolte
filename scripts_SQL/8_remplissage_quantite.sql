-- Table temporaire pour lier les quantites aux départements
CREATE TABLE t_tmp_quantite (
    id_tmp_quantite INT(4) NOT NULL AUTO_INCREMENT,
    tmp_total_quantite FLOAT(4) NOT NULL,
    tmp_quantite_commercialisable FLOAT(4) NOT NULL,
    tmp_quantite_non_commercialisable FLOAT(4) NOT NULL,
    tmp_numero_departement VARCHAR(4) NOT NULL,
    tmp_id_departement INT(4),
    CONSTRAINT pk_id_tmp_surface PRIMARY KEY(id_tmp_surface)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- On insert les valeurs qu'on veut dans notre table temporaire
INSERT INTO t_tmp_quantite (
    tmp_total_quantite,
    tmp_quantite_commercialisable,
    tmp_quantite_non_commercialisable,
    tmp_numero_departement)
    SELECT
        i_total_quantite,
        i_quantite_commercialisable,
        i_quantite_non_commercialisable,
        i_numero_departement
    FROM t_recolte_import;

-- On remplit le champs id_departement pour préparer la jointure
UPDATE t_tmp_surface AS tmp
SET tmp_id_departement =
    (SELECT id_departement
    FROM t_departement AS d
    WHERE tmp.tmp_numero_departement = d.numero_departement);

-- On transfert les valeurs dans la table t_quantite
INSERT INTO t_quantite (
    total_quantite,
    quantite_commercialisable,
    quantite_non_commercialisable,
    id_departement)
    SELECT
        tmp_total_quantite,
        tmp_quantite_commercialisable,
        tmp_quantite_non_commercialisable,
        tmp_id_departement
    FROM t_tmp_quantite;