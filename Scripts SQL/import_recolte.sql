-- On supprime la table si elle existe deja pour reinitialiser l'import
DROP TABLE IF EXISTS t_recolte_import;

CREATE TABLE t_recolte_import (
    id_recolte INT NOT NULL AUTO_INCREMENT,
    -- Informations sur les départements
    i_numero_departement VARCHAR(4) NOT NULL,
    i_libelle_departement VARCHAR(30) NOT NULL,
    -- Informations sur les déclarations de récoltes
    A ECRIRE;
    -- Informations sur la superficie des vignes
    i_total_surface FLOAT(4) NOT NULL,
    i_surface_aop FLOAT(4) NOT NULL,
    i_surface_cognac_armagnac FLOAT(4) NOT NULL,
    i_surface_igp FLOAT(4) NOT NULL,
    i_surface_vsig FLOAT(4) NOT NULL,
    -- Informations sur les quantités de vin produites
    i_total_quantite FLOAT(4) NOT NULL,
    
)