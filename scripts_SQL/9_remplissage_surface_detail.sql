-- Création de la table temporaire des détails surface
CREATE TABLE t_tmp_surface_detail (
    id_tmp_surface_detail INT(4) NOT NULL AUTO_INCREMENT,
    tmp_surface_aop FLOAT(4) NOT NULL,
    tmp_surface_cognac_armagnac FLOAT(4) NOT NULL,
    tmp_surface_igp FLOAT(4) NOT NULL,
    tmp_surface_vsig FLOAT(4) NOT NULL,
    tmp_numero_departement VARCHAR(4) NOT NULL,
    tmp_id_departement INT(4),
    tmp_id_surface INT(4),
    tmp_id_type INT(4),
    CONSTRAINT pk_id_tmp_surface_detail PRIMARY KEY(id_tmp_surface_detail)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- On insert les valeurs qu'on veut dans la table temporaire
INSERT INTO t_tmp_surface_detail (
    tmp_surface_aop,
    tmp_surface_cognac_armagnac,
    tmp_surface_igp,
    tmp_surface_vsig,
    tmp_numero_departement)
    SELECT
        i_surface_aop,
        i_surface_cognac_armagnac,
        i_surface_igp,
        i_surface_vsig,
        i_numero_departement
    FROM t_recolte_import;

-- On remplit le champs id_departement pour préparer la jointure
UPDATE t_tmp_surface_detail AS tmp
SET tmp_id_departement =
    (SELECT id_departement
    FROM t_departement AS d
    WHERE tmp.tmp_numero_departement = d.numero_departement);

-- A laide de l'id_departement, on retrouve la surface correspondante
UPDATE t_tmp_surface_detail AS tmp
SET tmp_id_surface =
    (SELECT id_surface
    FROM t_surface AS s
    WHERE tmp.tmp_id_departement = s.id_departement);


-- surface AOP
-- On remplit le champs id_type pour préparer la jointure
UPDATE t_tmp_surface_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS t
    WHERE t.libelle_type = 'AOP');

-- On transfert les valeurs dans la table surface detail
INSERT INTO t_surface_detail (
    id_type,
    id_surface,
    valeur_surface_detail)
    SELECT
        tmp_id_type,
        tmp_id_surface,
        tmp_surface_aop
    FROM t_tmp_surface_detail;


-- surface ACA
-- On remplit le champs id_type pour préparer la jointure
UPDATE t_tmp_surface_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS t
    WHERE t.libelle_type = 'ACA');

-- On transfert les valeurs dans la table surface detail
INSERT INTO t_surface_detail (
    id_type,
    id_surface,
    valeur_surface_detail)
    SELECT
        tmp_id_type,
        tmp_id_surface,
        tmp_surface_cognac_armagnac
    FROM t_tmp_surface_detail;


-- surface IGP
-- On remplit le champs id_type pour préparer la jointure
UPDATE t_tmp_surface_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS t
    WHERE t.libelle_type = 'IGP');

-- On transfert les valeurs dans la table surface detail
INSERT INTO t_surface_detail (
    id_type,
    id_surface,
    valeur_surface_detail)
    SELECT
        tmp_id_type,
        tmp_id_surface,
        tmp_surface_igp
    FROM t_tmp_surface_detail;


-- surface VSIG
-- On remplit le champs id_type pour préparer la jointure
UPDATE t_tmp_surface_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS t
    WHERE t.libelle_type = 'VSIG');

-- On transfert les valeurs dans la table surface detail
INSERT INTO t_surface_detail (
    id_type,
    id_surface,
    valeur_surface_detail)
    SELECT
        tmp_id_type,
        tmp_id_surface,
        tmp_surface_vsig
    FROM t_tmp_surface_detail;
