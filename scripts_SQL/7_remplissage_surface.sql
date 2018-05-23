-- Table temporaire pour lier les surfaces aux départements
CREATE TABLE t_tmp_surface (
    id_tmp_surface INT(4) NOT NULL AUTO_INCREMENT,
    tmp_total_surface FLOAT(10) NOT NULL,
    tmp_numero_departement VARCHAR(4) NOT NULL,
    tmp_id_departement INT(4),
    CONSTRAINT pk_id_tmp_surface PRIMARY KEY(id_tmp_surface)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- On insert les valeurs qu'on veut dans notre table temporaire
INSERT INTO t_tmp_surface (
    tmp_total_surface,
    tmp_numero_departement )
    SELECT 
        i_total_surface,
        i_numero_departement
    FROM t_recolte_import;

-- On remplit le champs id_departement pour préparer la jointure
UPDATE t_tmp_surface AS tmp
SET tmp_id_departement = 
    (SELECT id_departement
    FROM t_departement AS d
    WHERE tmp.tmp_numero_departement = d.numero_departement);

-- On transfert les valeurs dans la table t_surface
INSERT INTO t_surface (
    total_surface,
    id_departement )
    SELECT
        tmp_total_surface,
        tmp_id_departement
    FROM t_tmp_surface;
        
