-- On supprime la table si elle existe deja pour reinitialiser l'import
DROP TABLE IF EXISTS t_recolte_import;

CREATE TABLE t_recolte_import (
    id_recolte INT NOT NULL AUTO_INCREMENT,
    -- Informations sur les départements
    i_numero_departement VARCHAR(4) NOT NULL,
    -- Informations sur les déclarations de récoltes
    A ECRIRE;
    -- Informations sur la superficie des vignes
    i_total_surface FLOAT(4) NOT NULL,
    i_surface_aop FLOAT(4) NOT NULL,
    i_surface_cognac_armagnac FLOAT(4) NOT NULL,
    i_surface_igp FLOAT(4) NOT NULL,
    i_surface_vsig FLOAT(4) NOT NULL,
    -- Informations sur les quantités de vin produites
    i_quantite_aop_blanc FLOAT(4) NOT NULL,
    i_quantite_aop_rouge FLOAT(4) NOT NULL,
    i_quantite_aop_rose FLOAT(4) NOT NULL,
    i_quantite_aop_vsi FLOAT(4) NOT NULL,
    i_quantite_igp_blanc FLOAT(4) NOT NULL,
    i_quantite_igp_rouge FLOAT(4) NOT NULL,
    i_quantite_igp_rose FLOAT(4) NOT NULL,
    i_quantite_vsig_blanc FLOAT(4) NOT NULL,
    i_quantite_vsig_rouge FLOAT(4) NOT NULL,
    i_quantite_vsig_rose FLOAT(4) NOT NULL,
    i_quantite_cognac_armagnac FLOAT(4) NOT NULL,
    i_quantite_commercialisable FLOAT(4) NOT NULL,
    i_quantite_non_commercialisable FLOAT(4) NOT NULL,
    i_total_quantite FLOAT(4) NOT NULL,
    CONSTRAINT pk_id_recolte PRIMARY KEY(id_recolte)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '../ressources/csv_import/import_recolte_csv.csv' INTO
TABLE t_recolte_import
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';