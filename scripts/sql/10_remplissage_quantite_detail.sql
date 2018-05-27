-- Creation de la table temporaire des détails quantité
CREATE TABLE t_tmp_quantite_detail (
    id_tmp_quantite_detail INT(4) NOT NULL AUTO_INCREMENT,
    tmp_quantite_aop_blanc FLOAT(4) NOT NULL,
    tmp_quantite_aop_rouge FLOAT(4) NOT NULL,
    tmp_quantite_aop_rose FLOAT(4) NOT NULL,
    tmp_quantite_aop_vsi FLOAT(4) NOT NULL,
    tmp_quantite_igp_blanc FLOAT(4) NOT NULL,
    tmp_quantite_igp_rouge FLOAT(4) NOT NULL,
    tmp_quantite_igp_rose FLOAT(4) NOT NULL,
    tmp_quantite_vsig_blanc FLOAT(4) NOT NULL,
    tmp_quantite_vsig_rouge FLOAT(4) NOT NULL,
    tmp_quantite_vsig_rose FLOAT(4) NOT NULL,
    tmp_quantite_cognac_armagnac FLOAT(4) NOT NULL,
    tmp_numero_departement VARCHAR(4) NOT NULL,
    tmp_id_departement INT(4),
    tmp_id_quantite INT(4),
    tmp_id_categorie INT(4),
    tmp_id_type INT(4),
    CONSTRAINT pk_id_tmp_quantite_detail PRIMARY KEY(id_tmp_quantite_detail)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- On insert les valeurs qu'on veut fans la table temporaire
INSERT INTO t_tmp_quantite_detail (
    tmp_quantite_aop_blanc,
    tmp_quantite_aop_rouge,
    tmp_quantite_aop_rose,
    tmp_quantite_aop_vsi,
    tmp_quantite_igp_blanc,
    tmp_quantite_igp_rouge,
    tmp_quantite_igp_rose,
    tmp_quantite_vsig_blanc,
    tmp_quantite_vsig_rouge,
    tmp_quantite_vsig_rose,
    tmp_quantite_cognac_armagnac,
    tmp_numero_departement )
    SELECT
        i_quantite_aop_blanc,
        i_quantite_aop_rouge,
        i_quantite_aop_rose,
        i_quantite_aop_vsi,
        i_quantite_igp_blanc,
        i_quantite_igp_rouge,
        i_quantite_igp_rose,
        i_quantite_vsig_blanc,
        i_quantite_vsig_rouge,
        i_quantite_vsig_rose,
        i_quantite_cognac_armagnac,
        i_numero_departement
    FROM t_vigne_import;

-- On remplit le champs id_departement pour préparer la jointure
UPDATE t_tmp_quantite_detail AS tmp
SET tmp_id_departement = 
    (SELECT id_departement
    FROM t_departement AS d
    WHERE tmp.tmp_numero_departement = d.numero_departement);

-- A l'aide de l'id_departement, on retrouve la quantité correspondante
UPDATE t_tmp_quantite_detail AS tmp
SET tmp_id_quantite = 
    (SELECT id_quantite
    FROM t_quantite AS q
    WHERE tmp.tmp_id_departement = q.id_departement);


-- quantite AOP
-- On remplit le champs id_categorie pour préparer la jointure
UPDATE t_tmp_quantite_detail
SET tmp_id_categorie = 
    (SELECT id_categorie
    FROM t_categorie AS t
    WHERE t.libelle_categorie = 'AOP');

-- quantite aop blanc
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'blanc');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_aop_blanc
    FROM t_tmp_quantite_detail;

-- quantite aop rouge
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'rouge');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_aop_rouge
    FROM t_tmp_quantite_detail;

-- quantite aop rosé
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'rose');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail)
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_aop_rose
    FROM t_tmp_quantite_detail;

-- quantite aop vci vsi
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'vci_vsi');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_aop_blanc
    FROM t_tmp_quantite_detail;


-- quantite ACA
-- On remplit le champs id_categorie pour préparer la jointure
UPDATE t_tmp_quantite_detail
SET tmp_id_categorie = 
    (SELECT id_categorie
    FROM t_categorie AS t
    WHERE t.libelle_categorie = 'ACA');

-- pas de type
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'na');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_cognac_armagnac
    FROM t_tmp_quantite_detail;


-- quantite IGP
-- On remplit le champs id_categorie pour préparer la jointure
UPDATE t_tmp_quantite_detail
SET tmp_id_categorie = 
    (SELECT id_categorie
    FROM t_categorie AS t
    WHERE t.libelle_categorie = 'IGP');

-- quantite igp blanc
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'blanc');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_igp_blanc
    FROM t_tmp_quantite_detail;

-- quantite igp rouge
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'rouge');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_igp_rouge
    FROM t_tmp_quantite_detail;

-- quantite igp rose
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'rose');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_igp_rose
    FROM t_tmp_quantite_detail;

-- quantite VSIG
-- On remplit le champs id_categorie pour préparer la jointure
UPDATE t_tmp_quantite_detail
SET tmp_id_categorie = 
    (SELECT id_categorie
    FROM t_categorie AS t
    WHERE t.libelle_categorie = 'VSIG');

-- quantite vsig blanc
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'blanc');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_vsig_blanc
    FROM t_tmp_quantite_detail;

-- quantite vsig rouge
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'rouge');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_vsig_rouge
    FROM t_tmp_quantite_detail;

-- quantite vsig rose
UPDATE t_tmp_quantite_detail
SET tmp_id_type =
    (SELECT id_type
    FROM t_type AS c
    WHERE c.code_type = 'rose');

INSERT INTO t_quantite_detail (
    id_categorie,
    id_quantite,
    id_type,
    valeur_quantite_detail )
    SELECT
        tmp_id_categorie,
        tmp_id_quantite,
        tmp_id_type,
        tmp_quantite_vsig_rose
    FROM t_tmp_quantite_detail;

-- On supprime les tables temporaires
DROP TABLE t_tmp_quantite_detail;

-- On supprime la table vigne
DROP TABLE t_vigne_import;